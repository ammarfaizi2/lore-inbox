Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbTEAE1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 00:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbTEAE1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 00:27:05 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:60079 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262300AbTEAE1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 00:27:02 -0400
Date: Wed, 30 Apr 2003 21:39:18 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: mc@stanford.edu
Subject: [CHECKER] 5 potential user-pointer errors that allow arbitrary reads
 from kernel
Message-ID: <Pine.GSO.4.44.0304302131150.22117-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a resend (the previous report was ignored, however I feel that
these bugs could be severe).

Here are 5 bugs in 2.5.63 where user pointers are passed into memcpy or
simple_strtoul without verifications. These bugs appear functions assigned
to struct proc_dir_entry.write_proc, where a malicious user can call
write_proc on a arbitrary pointer pointing to any sensitive kernel data,
then call the corresponding read_proc to get back the data.

Please confirm or clarify. Thanks!

-Junfeng

---------------------------------------------------------
[BUG] proc_dir_entry.write_proc can take tainted inputs

/home/junfeng/linux-2.5.63/drivers/usb/media/vicam.c:1117:vicam_write_proc_gain:
ERROR:TAINTED:1117:1117: passing tainted ptr 'buffer' to simple_strtoul
[Callstack:
/home/junfeng/linux-2.5.63/net/core/pktgen.c:991:vicam_write_proc_gain((tainted
1))]

static int vicam_write_proc_gain(struct file *file, const char *buffer,
				unsigned long count, void *data)
{
	struct vicam_camera *cam = (struct vicam_camera *)data;


Error --->
	cam->gain = simple_strtoul(buffer, NULL, 10);

	return count;
}
---------------------------------------------------------
[BUG] proc_dir_entry.write_proc can take tainted inputs

/home/junfeng/linux-2.5.63/drivers/usb/media/vicam.c:1107:vicam_write_proc_shutter:
ERROR:TAINTED:1107:1107: passing tainted ptr 'buffer' to simple_strtoul
[Callstack:
/home/junfeng/linux-2.5.63/net/core/pktgen.c:991:vicam_write_proc_shutter((tainted
1))]

static int vicam_write_proc_shutter(struct file *file, const char *buffer,
				unsigned long count, void *data)
{
	struct vicam_camera *cam = (struct vicam_camera *)data;


Error --->
	cam->shutter_speed = simple_strtoul(buffer, NULL, 10);

	return count;
}
---------------------------------------------------------
[BUG] proc_dir_entry.write_proc

/home/junfeng/linux-2.5.63/drivers/media/video/zoran_procfs.c:122:zoran_write_proc:
ERROR:TAINTED:122:122: passing tainted ptr 'buffer' to __memcpy
[Callstack:
/home/junfeng/linux-2.5.63/net/core/pktgen.c:991:zoran_write_proc((tainted
1))]

	string = sp = vmalloc(count + 1);
	if (!string) {
		printk(KERN_ERR "%s: write_proc: can not allocate
memory\n", zr->name);
		return -ENOMEM;
	}

Error --->
	memcpy(string, buffer, count);
	string[count] = 0;
	DEBUG2(printk(KERN_INFO "%s: write_proc: name=%s count=%lu
data=%x\n", zr->name, file->f_dentry->d_name.name, count, (int) data));
	ldelim = " \t\n";
---------------------------------------------------------
[BUG] proc_dir_entry.write_proc

/home/junfeng/linux-2.5.63/drivers/pnp/pnpbios/proc.c:190:proc_write_node:
ERROR:TAINTED:190:190: passing tainted ptr 'buf' to __memcpy [Callstack:
/home/junfeng/linux-2.5.63/net/core/pktgen.c:991:proc_write_node((tainted
1))]

	if (!node) return -ENOMEM;
	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
		return -EIO;
	if (count != node->size - sizeof(struct pnp_bios_node))
		return -EINVAL;

Error --->
	memcpy(node->data, buf, count);
	if (pnp_bios_set_dev_node(node->handle, boot, node) != 0)
	    return -EINVAL;
	kfree(node);
---------------------------------------------------------
[BUG] proc_dir_entry.write_proc can take tainted inputs.
av7110_ir_write_proc is assigned to proc_dir_entry.write_proc

/home/junfeng/linux-2.5.63/drivers/media/dvb/av7110/av7110_ir.c:116:av7110_ir_write_proc:
ERROR:TAINTED:116:116: passing tainted ptr 'buffer' to __constant_memcpy
[Callstack:
/home/junfeng/linux-2.5.63/net/core/pktgen.c:991:av7110_ir_write_proc((tainted
1))]

	u32 ir_config;

	if (count < 4 + 256 * sizeof(u16))
		return -EINVAL;


Error --->
	memcpy (&ir_config, buffer, 4);
	memcpy (&key_map, buffer + 4, 256 * sizeof(u16));

	av7110_setup_irc_config (NULL, ir_config);



