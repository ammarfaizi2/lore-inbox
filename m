Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTI3VCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbTI3VCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:02:19 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:13037 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S261732AbTI3VBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:01:47 -0400
Subject: 2.6.0-test6: more __init bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: mikep@linuxtr.net, mike.mclagan@linux.org, minyard@mvista.com,
       jes@trained-monkey.org, sjralston1@netscape.net, Pam.Delaney@lsil.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Sep 2003 13:59:14 -0700
Message-Id: <1064955628.5734.229.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some cases where __init code or data is referenced by 
non-__init code.

Questions:
- Is init_module allowed, required or forbidden to be __init?
- Ditto for Scsi_Host_Template.detect()?
- Ditto for net_device->set_config()?

Thanks for looking at these potential bugs, and sorry if I've made 
any mistakes.

Best,
Rob

P.S. All these bugs were found with Cqual, the bug-finding tool
developed by Jeff Foster, John Kodumal, and many others, and available
at http://www.cs.umd.edu/~jfoster/cqual/, although the currently
released version of cqual only has primitive support for 
__init bug-finding.


Linux 2.6.0-test6:

** Probably a bug:
** drivers/net/tokenring/ibmtr.c:channel_def                          (__init)
   referenced by drivers/net/tokenring/ibmtr.c:ibmtr_probe1()         (__devinit)
     called by drivers/net/tokenring/ibmtr.c:ibmtr_probe()            (__devinit)
     is stored in a dev_link_t->irq.Instance->init()
     returned by drivers/net/pcmcia/ibmtr_cs.c:ibmtr_attach()         (not __init)
Note: So it looks like ibmtr_probe() can be called any time
      a token ring pcmcia card is inserted, which may be after
      init-time
Fix: Make all this stuff non-__init when it's used for the pcmcia 
     version of the driver?

** Probably a bug?
** drivers/net/wan/sdla.c:valid_port                                  (__init)
   referenced by sdla_set_config()                                    (not __init)
Note: sdla_set_config() is stored as a net_device->set_config().
      Is such a function allowed to touch __init data?
Fix: declare valid_port as not __init.

** Possible bug:
** drivers/net/tokenring/3c359.c:xl_init()                            (__init)
     called by xl_probe()                                             (__devinit)
Fix: declare xl_init __devinit or declare xl_probe __init.
Note: xl_probe is used as a pci_driver->probe() field.

** Possible bug:
** drivers/char/ipmi/ipmi_msghandler.c:ipmi_init_msghandler()         (__init)
     called by numerous non-__init functions
Note: ipmi_init_msghandler() is an alias for init_module
Fix: declare ipmi_init_msghandler non-__init.

** Code can be declared __init
** drivers/net/acenic.c:probed                                        (__init)
   referenced by: acenic_probe()                                      (__devinit)
     only caller: ace_module_init()                                   (__init)
Fix: Make acenic_probe() __init?

** Probably not a bug?
** drivers/message/fusion/mptscsih.c:mptscsih_setup()                 (__init)
     called from drivers/message/fusion/mptscsih.c:mptscsih_detect()  (not __init)
Note: mptscsih_detect() is a Scsi_Host_Template.detect() function.
      Can detect() functions be __init?
Fix: either declare mptscsih_setup() non-__init OR
     declare mptscsih_detect() as __init

** Probably not a bug?
** drivers/scsi/qla1280.c:driver_setup                                (__init)
   referenced by qla1280_read_nvram()                                 (not __init)
     called by qla1280_initialize_adapter()                           (not __init)
       called by qla1280_do_device_init()                             (not __init)
         called by qla1280_detect()                                   (not __init)
Note: qla1280_detect is a Scsi_Host_Template->detect() routine.
Fix: make all this stuff __init?


