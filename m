Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbQLGSah>; Thu, 7 Dec 2000 13:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbQLGSaS>; Thu, 7 Dec 2000 13:30:18 -0500
Received: from sun.rhrk.uni-kl.de ([131.246.137.50]:17538 "HELO
	sun.rhrk.uni-kl.de") by vger.kernel.org with SMTP
	id <S129846AbQLGSaM>; Thu, 7 Dec 2000 13:30:12 -0500
Message-ID: <3A2FD00F.E7449D2D@student.uni-kl.de>
Date: Thu, 07 Dec 2000 18:59:43 +0100
From: strieder@student.uni-kl.de
Organization: Universität Kaiserslautern
X-Mailer: Mozilla 4.74 [de] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SCSI modules and kmod
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the problem is, that SCSI hostadapter modules seem not to be loaded
automatically, whenever there is another hostadaptor active already, or
if IDE SCSI emulation is enabled.

Loading automatically is usually done via having kmod load the virtual
module "scsi_hostadapter", which is usually translated by modprobe via
an entry in /etc/modules.conf to the right module to be loaded. This
doesn't happen in my case. Instead there is a message from modprobe,
that module block-major-8 (/dev/sda...) could not be loaded, so there is
something tried.

The following is from linux/drivers/scsi/scsi.c:

int scsi_register_module(int module_type, void * ptr)
{
    switch(module_type)
    {
    case MODULE_SCSI_HA:
        return scsi_register_host((Scsi_Host_Template *) ptr);
 
        /* Load upper level device handler of some kind */
    case MODULE_SCSI_DEV:
#ifdef CONFIG_KMOD
        if (scsi_hosts == NULL)
            request_module("scsi_hostadapter");
#endif
        return scsi_register_device_module((struct Scsi_Device_Template
*) ptr);
        /* The rest of these are not yet implemented */
 
        /* Load constants.o */
    case MODULE_SCSI_CONST:
 
        /* Load specialized ioctl handler for some device.  Intended for
         * cdroms that have non-SCSI2 audio command sets. */
    case MODULE_SCSI_IOCTL:
 
    default:
        return 1;
    }
} 

It seems to be the case that scsi_hosts != NULL holds, whenever ide-scsi
is enabled. This prevents other (real) SCSI adapter drivers from being
loaded automatically.

What could be done? 

Perhaps it is better to try first to find the device. If that fails try
to load the module, then try once again to register the device.

In other words changing the case of the function above like the
following could perhaps do it.

    int regdevresult;
....
    case MODULE_SCSI_DEV:
#ifdef CONFIG_KMOD
        if (scsi_hosts == NULL)
          {
            request_module("scsi_hostadapter");
            return scsi_register_device_module((struct
Scsi_Device_Template *) ptr);
          }
#endif
        regdevresult = scsi_register_device_module((struct
Scsi_Device_Template *) ptr);
#ifdef CONFIG_KMOD
        if (regdevresult != 0) /* is this the right case? */
            request_module("scsi_hostadapter");
        regdevresult = scsi_register_device_module((struct
Scsi_Device_Template *) ptr);
#endif
        return regdevresult;

This would be the first time I really change the kernel, so I thought
it'd be better to ask, if this could work before losing too much time.

The only change in behaviour will be that trying to access a SCSI device
that isn't there will result in as many calls to modprobe as accesses
are tried. The current code will only show this, if scsi_hosts == NULL
and remains so after loading the module. This is not a major change, and
it will happen just in cases of misconfiguration of the system.

It is important that the kernel tries to tell modprobe that it looks for
a SCSI hostadapter. "modprobe" itself can do a lot more with that, e.g.
loading multiple SCSI drivers, loading other modules, etc.

Please CC me in answers, I'm not in the list.

Bernd Strieder
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
