Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLMBck>; Tue, 12 Dec 2000 20:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLMBca>; Tue, 12 Dec 2000 20:32:30 -0500
Received: from p062-20.netc.pt ([212.18.175.62]:51850 "HELO tuphir.dune.pt")
	by vger.kernel.org with SMTP id <S129226AbQLMBcS>;
	Tue, 12 Dec 2000 20:32:18 -0500
From: skinbits@substancia.com
Date: Wed, 13 Dec 2000 01:00:37 +0000
To: linux-kernel@vger.kernel.org
Subject: scsi_unregister_device
Message-ID: <20001213010037.A2201@substancia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

As part of our final year project, we are implementing a network based on
SCSI to use as a cheap fast eth link. 

This module is made of two parts:

	-sn: A scsi device that talk with the scsi mid layer
	-scsinet: A network device driver that talks with sn.

We made a module based on code allready made for kernel 2.1.97, ported
it to 2.4.0test10, and put it as a module. The module allready loads,
both subsystems are initialized and the kernel dosen't crash :))

The problem happens when we try to load our module without a SCSI device
driver loaded (We use Symbios 53c8xx). When that happens, we register
sn with scsi_register_device, but when we try to init scsinet, it fails
(there are no devices to talk to, so it will fail). So, before our
module is unloaded, we try to unregister the sn device using
scsi_unregister_device. All is allright, the module get's out, but, the
usage count of the scsi_mod.o dosen't decrement. So it stays blocked in
the kernel and we can't unload it...

the relevant code is something like:

static int __init init_sc(void) 
{
	int ret;
	
	sn_template.module=THIS_MODULE;
	if ((ret=scsi_register_module(MODULE_SCSI_DEV,&sn_template))!=0)
		return ret;

	if ((ret=register_netdev(&scsinet_template)!=0) 
	{
		scsi_unregister_module(MODULE_SCSI_DEV,&sn_template);
		sn_template.dev_max=0;
		return ret;
	}

	return 0;
}

sn_template is the template for the scsi device, scsinet_template is the
template for a ehternet driver.

Anyone knows what we are doing wrong?

Pedro Semeano	
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
