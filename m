Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUJLPMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUJLPMS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUJLPKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:10:47 -0400
Received: from roadrunner.doc.ic.ac.uk ([146.169.1.193]:6111 "EHLO
	roadrunner.doc.ic.ac.uk") by vger.kernel.org with ESMTP
	id S264639AbUJLPDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:03:38 -0400
Message-ID: <416BF258.90204@doc.ic.ac.uk>
Date: Tue, 12 Oct 2004 16:03:52 +0100
From: David McBride <dwm99@doc.ic.ac.uk>
Organization: Department of Computing, Imperial College, London
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: No atime updates of /dev nodes on local keyboard, mouse input in
 2.4.26
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Some software, such as Condor[1], depends on the fact that the atime of 
the /dev/console and /dev/input/mice files is updated when keystrokes 
are entered or a mouse is used, respectively.

However, certainly in recent kernels (I've tried stock 2.4.21 and 
2.4.26) this doesn't appear to be the case.  As I'm running Condor (for 
which source isn't available) and depend on these atime update semantics 
for correct operation I'm trying to re-add this functionality.

I found via Google a patch[2] to do exactly this for 2.6; I've been 
trying to implement my own equivilent on 2.4.  However, I'm not at all 
familiar with the kernel internals and could use some help from someone 
with a better understanding of the code involved.

Specifically, the patch above for evdev.c and related input drivers 
apply cleanly on 2.4.26 -- and they work; atimes are now updated when 
mouse input occurs.

However,  PS/2 keyboard support is more problematic.  Code to do what I 
want already appears to exist in drivers/char/pc_keyb.c:

static ssize_t read_aux(struct file * file, char * buffer,
                         size_t count, loff_t *ppos)
{
	[...]

         if (count-i) {
                 file->f_dentry->d_inode->i_atime = CURRENT_TIME;
                 return count-i;
         }
	
	[...]

However, no /dev node receives an atime update when keystrokes are 
entered *and* when I added debugging printks to this section of code no 
messages appeared in dmesg -- suggesting that this conditional never 
evaluates to true.  (I suspect that this function never gets called at all.)

I'm now a little lost.  Can anyone help?
(If you reply, please explicitly CC me.)

Cheers,
Davidj
[2] http://www.ussg.iu.edu/hypermail/linux/kernel/0406.1/1612.html

-- 
David McBride <dwm99@doc.ic.ac.uk>
Department of Computing, Imperial College, London
