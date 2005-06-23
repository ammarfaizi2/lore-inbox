Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVFWSw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVFWSw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbVFWSuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:50:10 -0400
Received: from k1.dinoex.de ([80.237.200.138]:61675 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S263041AbVFWSqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:46:14 -0400
From: Jochen Hein <jochen@jochen.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [TPM] broken /proc/misc entry
CC: kjhall@us.ibm.com, tpmdd-devel@lists.sourceforge.net
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
Date: Thu, 23 Jun 2005 20:41:57 +0200
Message-ID: <874qboj4p6.fsf@echidna.jochen.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On my system I do have configured:

root@hermes:/dev# grep TPM /usr/src/linux-2.6.12/.config
# TPM devices
CONFIG_TCG_TPM=m

TPM is loaded:
root@hermes:/dev# lsmod | grep tpm
tpm_nsc                 6272  0
tpm_atmel               4992  0
tpm                    10496  2 tpm_nsc,tpm_atmel

/proc/misc contains:

root@hermes:/dev# cat /proc/misc
224
ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ!
 63 device-mapper
200 tun
  1 psaux
175 agpgart
130 watchdog
144 nvram
135 rtc

After I removed the TPM modules I get:
root@hermes:/dev# rmmod tpm_nsc
root@hermes:/dev# rmmod tpm_atmel
root@hermes:/dev# rmmod tpm
root@hermes:/dev# cat /proc/misc
 63 device-mapper
200 tun
  1 psaux
175 agpgart
130 watchdog
144 nvram
135 rtc

Why on earth do we need to obfuscate the loaded TPM modules and the
misc minor number in that way?  ls -l /dev/tpm gave that away easily.

>From the source:

        if (misc_register(&chip->vendor->miscdev)) {
                dev_err(&chip->pci_dev->dev,
                        "unable to misc_register %s, minor %d\n",
                        chip->vendor->miscdev.name,
                        chip->vendor->miscdev.minor);
                pci_dev_put(pci_dev);
                kfree(chip);
                dev_mask[i] &= !(1 << j);
                return -ENODEV;
        }

Maybe it's a bad idea to use &chip->vendor->miscdev for registering
the misc device?

Jochen

-- 
#include <~/.signature>: permission denied
