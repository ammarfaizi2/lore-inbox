Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932965AbWFZTgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932965AbWFZTgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932963AbWFZTgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:36:46 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:40628 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932958AbWFZTgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:36:44 -0400
Date: Mon, 26 Jun 2006 15:36:06 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Message-ID: <20060626193606.GJ8985@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m1veqnst2b.fsf@ebiederm.dsl.xmission.com> <E717642AF17E744CA95C070CA815AE550E163F@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E717642AF17E744CA95C070CA815AE550E163F@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 01:51:43PM -0500, Miller, Mike (OS Dev) wrote:

[..]
> > Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver 
> > initialization issue fix
> > 
> > "Miller, Mike (OS Dev)" <Mike.Miller@hp.com> writes:
> > 
> > > Thanks Eric, that helps me understand. Section 8.2.2 of the 
> > open cciss 
> > > spec supports a reset message. Target 0x00 is the 
> > controller. We could 
> > > add this to the init routine to ensure the board is made sane again 
> > > but this would drastically increase init time under normal 
> > circumstances.
> > 
> > Where does the init time penalty come from? How large is the 
> > init penalty?  I suspect it is from waiting for the scsi 
> > disks to spin up.
> > But I am just guessing in the dark.
> 
> The penalty is in the firmware and self-test operations.
> 
> > 
> > > And I suspect this is a hard reset, also. Not sure if that would 
> > > negatively impact kdump. If there were some condition we could test 
> > > against and perform the reset when that condition is met it 
> > would not 
> > > impact 99.9% of users.
> > 
> > I am wondering if it is possible to look at the controller 
> > and see if it is in a bad state, (i.e. in some state besides 
> > just coming out of reset) and if so issue a reset.  If this 
> > really is a long operation that would be the ideal way to handle it.
> 
> It's not really in a bad state at this time, is it? Maybe some commands
> hanging around.

That's true. Only some commands are hanging around and currently
only a warning is printed, if CONFIG_CISS_SCSI_TAPE is not enabled.
Otherwise, driver thinks that there is on reasons for me receiving
a command completion message for a command which I never issued and
it runs in to the BUG().

                /* This will need changing for direct lookup completions */
                if (complete != c->busaddr) {
                        if (add_sendcmd_reject(cmd, ctlr, complete) != 0) {
                                BUG(); /* we are pretty much hosed if we get here. */
                        }
                        continue;

> 
> > 
> > If the amount of time is really user noticeable and testing 
> > for it is impossible then it is probably time to talk kernel 
> > command line options.
> 
> I was informed of the crashboot command line parameter. I can implement
> that as a test.
> 

Now as per Andrew's suggestion, I have changed crashboot to "reset_devices".

Please find attached the patch. Now reset functionality of cciss driver
needs to be implemented.

Thanks
Vivek



o Introduce "reset_devices" command line option.

o Resetting the devices during driver initialization can be a costly
  operation in terms of time (especially scsi devices). This option can
  be used by drivers to know that user forcibly wants the devices to be
  reset during initialization.

o This option can be useful while kernel is booting in unreliable
  environment. For ex. during kdump boot where devices are in 
  unknown random state and BIOS execution has been skipped.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.17-1M-vivek/Documentation/kernel-parameters.txt |    3 ++
 linux-2.6.17-1M-vivek/include/linux/init.h                |    1 
 linux-2.6.17-1M-vivek/init/main.c                         |   20 ++++++++++++++
 3 files changed, 24 insertions(+)

diff -puN init/main.c~add-reset-devices-command-line-option init/main.c
--- linux-2.6.17-1M/init/main.c~add-reset-devices-command-line-option	2006-06-26 13:53:51.000000000 -0400
+++ linux-2.6.17-1M-vivek/init/main.c	2006-06-26 15:06:12.000000000 -0400
@@ -125,6 +125,18 @@ static char *ramdisk_execute_command;
 static unsigned int max_cpus = NR_CPUS;
 
 /*
+ * If set, this is an indication to the drivers that reset the underlying
+ * device before going ahead with the initialization otherwise driver might
+ * rely on the BIOS and skip the reset operation.
+ *
+ * This is useful if kernel is booting in an unreliable environment.
+ * For ex. kdump situaiton where previous kernel has crashed, BIOS has been
+ * skipped and devices will be in unknown state.
+ */
+unsigned int reset_devices;
+EXPORT_SYMBOL(reset_devices);
+
+/*
  * Setup routine for controlling SMP activation
  *
  * Command-line option of "nosmp" or "maxcpus=0" will disable SMP
@@ -150,6 +162,14 @@ static int __init maxcpus(char *str)
 
 __setup("maxcpus=", maxcpus);
 
+static int __init set_reset_devices(char *str)
+{
+	reset_devices = 1;
+	return 1;
+}
+
+__setup("reset_devices", set_reset_devices);
+
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 static const char *panic_later, *panic_param;
diff -puN include/linux/init.h~add-reset-devices-command-line-option include/linux/init.h
--- linux-2.6.17-1M/include/linux/init.h~add-reset-devices-command-line-option	2006-06-26 14:44:22.000000000 -0400
+++ linux-2.6.17-1M-vivek/include/linux/init.h	2006-06-26 14:44:51.000000000 -0400
@@ -69,6 +69,7 @@ extern initcall_t __security_initcall_st
 
 /* Defined in init/main.c */
 extern char saved_command_line[];
+extern unsigned int reset_devices;
 
 /* used by init/main.c */
 extern void setup_arch(char **);
diff -puN Documentation/kernel-parameters.txt~add-reset-devices-command-line-option Documentation/kernel-parameters.txt
--- linux-2.6.17-1M/Documentation/kernel-parameters.txt~add-reset-devices-command-line-option	2006-06-26 14:45:01.000000000 -0400
+++ linux-2.6.17-1M-vivek/Documentation/kernel-parameters.txt	2006-06-26 14:47:20.000000000 -0400
@@ -1340,6 +1340,9 @@ running once the system is up.
 
 	reserve=	[KNL,BUGS] Force the kernel to ignore some iomem area
 
+	reset_devices	[KNL] Force drivers to reset the underlying device
+			during initialization.
+
 	resume=		[SWSUSP]
 			Specify the partition device for software suspend
 
_
