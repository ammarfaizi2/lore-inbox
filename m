Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbUCGQ4p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 11:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbUCGQ4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 11:56:39 -0500
Received: from mail4.speakeasy.net ([216.254.0.204]:5064 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S262308AbUCGQzi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 11:55:38 -0500
Message-ID: <404B5483.30309@speakeasy.net>
Date: Sun, 07 Mar 2004 11:57:39 -0500
From: Dino Klein <zagzag-lists@speakeasy.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI, PM, & sysfs interaction
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody, [please CC me]
I was trying the other day to put my 3Com NIC to D3, by issuing:
"echo -n 3 > /sys/......./power/state"

When I checked the "state" file again it claimed to be "3", however the 
output from "lspci -vv" asserted that the NIC was still in D0.
I started digging around the code, and made the following modifications 
(below), since I did not load the driver (3c59x) at the time.

--- linux-2.6.3/drivers/pci/pci-driver.c	2004-03-07 10:12:41.865239176 -0500
+++ linux-2.6.3-initramfs/drivers/pci/pci-driver.c	2004-03-07 
10:17:22.205620960 -0500
@@ -300,8 +300,18 @@
  	struct pci_dev * pci_dev = to_pci_dev(dev);
  	struct pci_driver * drv = pci_dev->driver;

-	if (drv && drv->suspend)
-		return drv->suspend(pci_dev,state);
+	if (drv)
+	{
+		if (drv->suspend)
+		{
+			return drv->suspend(pci_dev,state);
+		}
+		else return -EIO; // FIXME: just a guess
+	}
+	else
+	{
+		return pci_set_power_state(pci_dev, state);
+	}
  	return 0;
  }


After recompiling and rebooting, I give it another try, but still no 
good. This time I trace the "problem" to 
kernel/drivers/pci/probe.c@pci_setup_device(), where the 
pci_dev->current_state is set as follows:
	/* "Unknown power state" */
	dev->current_state = 4;

After adding a few printk()'s, this is what the system thinks that the 
NIC's state is after boot, without any driver loaded:
actual state via "lspci -vv": 0 (D0)
pci_dev->current_state: 4 (the invalid state)
pci_dev->dev.power.state(used by sysfs): 0 (D0) [initialized where?]
pci_dev->dev.power_state: ? (didn't check; doesn't seem to be used)

This explains why "echo -n 3 > /sysfs.." doesn't work after the applying 
the patch above - pci_set_power_state() fails with -EINVAL, due to an 
attempted invalid state transition, i.e. pci_dev->current_state==4 to D3 
(transitions to D1/2/3 are allowed only from D0).
Next, my problem is to get pci_dev->current_state to reflect the real 
state of the NIC. So, instead of modifying pci_setup_device() to read 
the actual state from the PM register, or whatever other default it 
might be, I simply load and remove the NIC driver, which causes the 
correct value to be set in pci_dev->current_state.
Note: I didn't modify pci_setup_device(), because I didn't read any PCI 
spec.

Yet another problem - while I load and remove the NIC driver, I notice 
another inconsistency. When the driver initially loads, it sets the NIC 
in D3, and back to D0 upon an "ifconfig up". It sets it back to D3 after 
"ifconfig down", and to D0 upon driver removal.
However, the D3 state is not reflected in /sys/..../power/state, so I 
add the following:

--- linux-2.6.3/drivers/pci/pci.c	2004-01-09 01:59:19.000000000 -0500
+++ linux-2.6.3-initramfs/drivers/pci/pci.c	2004-03-07 
10:15:42.377797096 -0500
@@ -202,6 +202,8 @@
  	return best;
  }

+extern void dpm_set_power_state (struct device *dev, u32 state);
+
  /**
   * pci_set_power_state - Set the power state of a PCI device
   * @dev: PCI device to be suspended
@@ -274,6 +276,7 @@
  	else if(state == 2 || dev->current_state == 2)
  		udelay(200);
  	dev->current_state = state;
+	dpm_set_power_state(&dev->dev, state);

  	return 0;
  }


That works nicely for the NIC driver, plus the placement make sense, but 
it doesn't work for me when I try "echo -n 3 > /sys/...." !!
Once again, several printk()'s later I figure out that there is a 
deadlock, which goes as follows:
drivers/base/power/sysfs.c@state_store()
drivers/base/power/runtime.c@dpm_runtime_suspend() - acquire dpm_sem
drivers/base/power/suspend.c@suspend_device()
drivers/pci/pci-drivers@pci_suspend_device()
....
[3c59x.c internals]
....
drivers/pci/pci_set_power_state()
drivers/base/power/runtime.c@dpm_set_power_state() - deadlock on dpm_sem


Conclusion - with the above modifications, the driver does not deadlock 
when suspending and resuming, since the semaphore is not acquired yet. 
However, when trying to manually suspend the device, the semaphore is 
acquired, and then another attempt is made, which deadlocks.

This exercise raised several questions, which I hope somebody might help 
answer them:
(1) how stable is the interface? (no other drivers used 
dpm_set_power_state).
(2) shouldn't the PCI layer store the real state of a device, instead of 
using a bogus state?
(3) is there a way to verify semaphore ownership?

And again, please CC me.
