Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbVAFQ2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVAFQ2Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVAFQ1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:27:49 -0500
Received: from quechua.inka.de ([193.197.184.2]:17582 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262898AbVAFQ1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:27:15 -0500
Message-ID: <41DD66CC.9070805@bigred.inka.de>
Date: Thu, 06 Jan 2005 17:26:52 +0100
From: Olaf Titz <olaf@bigred.inka.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040925
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Andrew de Quincey <adq_dvb@lidskialf.net>
CC: linux-dvb@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb] Re: dvb-kernel crasher
References: <E1CiIqc-0007WV-00@bigred.inka.de> <200501041222.21644.adq_dvb@lidskialf.net> <41DBE3C8.9050003@inka.de> <200501051404.43182.adq_dvb@lidskialf.net>
In-Reply-To: <200501051404.43182.adq_dvb@lidskialf.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[CC to linux-kernel]

After more debugging I found the most likely suspect to be GCC 3.3.3.
Compiling with GCC 2.95 makes the problem go away.

Here's more analysis:

1. I tried with preempt off since the fops_get path gets much more
complex with preempt. Same result, i.e. crashes. The following is with 
preempt off.
2. Inserted debug into try_module_get. The crash happens before
try_module_get is called.

The relevant routines look now like the following (no functional
changes, only debug output):


static inline int try_module_get(struct module *module)
{
	int ret = 1;

	if (module) {
		unsigned int cpu = get_cpu();
#ifdef DEBUG_DVB
                 printk(KERN_DEBUG
                        "try_module_get(%s): cpu=%d state=%d count=%d ",
                        module->name, module->state, 
module->ref[cpu].count);
#endif
		if (likely(module_is_live(module)))
			local_inc(&module->ref[cpu].count);
		else
			ret = 0;
		put_cpu();
#ifdef DEBUG_DVB
                 printk("ret=%d\n", ret);
#endif
	}
	return ret;
}

static int dvb_device_open(struct inode *inode, struct file *file)
{
	struct dvb_device *dvbdev;

	dvbdev = dvbdev_find_device (iminor(inode));
         if (dvbdev_debug) {
             printk(KERN_DEBUG "dvb_device_open: i_rdev=%x ", 
inode->i_rdev);
             if (dvbdev) {
                 print_symbol("dvbdev=%s ", dvbdev);
                 print_symbol("fops=%s ", dvbdev ? dvbdev->fops : 0);
             } else {
                 printk("dvbdev=NULL ");
             }
             printk("file=%p ", file);
             print_symbol("f_op=%s ", file->f_op);
             printk("f_flags=%x private_data=%x\n",
                    file->f_flags, file->private_data);
         }
	if (dvbdev && dvbdev->fops) {
  		int err = 0;
		struct file_operations *old_fops;

		file->private_data = dvbdev; /**** see below ****/
		old_fops = file->f_op; /**** see below ****/
                 file->f_op = fops_get(dvbdev->fops);
                 if (dvbdev_debug)
                         print_symbol("dvb_device_open: open=%s ",
                                      file->f_op->open);
                 if(file->f_op->open)
                         err = file->f_op->open(inode,file);
                 if (err) {
                         fops_put(file->f_op);
                         file->f_op = fops_get(old_fops);
                 }
                 fops_put(old_fops);
                 dprintk("result=%d\n", err);
                 return err;
	}
         dprintk(KERN_DEBUG "dvb_device_open: result=ENODEV\n");
	return -ENODEV;
}

This gives output like this in normal operation:
Jan  6 11:15:18 bigred kernel: dvb_device_open: i_rdev=d400004
dvbdev=0xcfff41e0 fops=dvb_demux_fops+0x0/0xffff81e0 [dvb_core]
file=c0505560 f_op=dvb_device_fops+0x0/0xffff8280 [dvb_core] f_flags=802
private_data=0
Jan  6 11:15:18 bigred kernel: try_module_get(budget_ci): cpu=0 state=16
count=1 ret=1
Jan  6 11:15:18 bigred kernel: dvb_device_open: 
open=dvb_demux_open+0x0/0x110 [dvb_core] result=0

3. The crash now looks like this:

Jan  6 11:15:19 bigred kernel: dvb_device_open: i_rdev=d400003 
dvbdev=0xcfff4620 fops=dvb_frontend_fops+0x0/0xffff7ca0 [dvb_core] 
file=c0a4bb00 f_op=dvb_device_fops+0x0/0xffff8280 [dvb_core] f_flags=0 
private_data=0
Jan  6 11:15:19 bigred kernel: Unable to handle kernel paging request at 
virtual address d0a97580
Jan  6 11:15:19 bigred kernel:  printing eip:
Jan  6 11:15:19 bigred kernel: d0aa20d8
Jan  6 11:15:19 bigred kernel: *pde = 0ffcb067
Jan  6 11:15:19 bigred kernel: *pte = 00000000
Jan  6 11:15:19 bigred kernel: Oops: 0000 [#1]

4. Further digging with a disassembler into the module suggests that the 
crash happens at one of the statements marked "see below". The debug 
output, however, shows that the "file" pointer is most likely _not_ 
corrupted. This leaves not many possible reasons.

I've not exactly understood what the compiler makes of these statements 
though, so I tried another compiler, and voila - it works.

----

So can some kernel guru perhaps look into what GCC 3.3.3 makes of 
fops_get()? Perhaps we have a compiler bug or some sort of unfortunate 
interaction with the nontrivial macroized code...

Thanks for your help anyway,

Olaf

