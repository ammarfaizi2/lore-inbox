Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTD1Xuc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 19:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTD1Xuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 19:50:32 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:64929 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261182AbTD1Xu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 19:50:28 -0400
Date: Mon, 28 Apr 2003 17:02:38 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: mc@cs.stanford.edu
Subject: [CHECKER] 5 potential user-pointer errors in write_proc
In-Reply-To: <Pine.GSO.4.44.0304281206330.19401-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0304281652490.23829-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here are 5 bugs in 2.5.63 where the second argument of
proc_dir_entry.write_proc argument is passed into dereference-like
functions (memcpy, simple_strtoul).

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


