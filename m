Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbUJZVn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbUJZVn1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbUJZVn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:43:27 -0400
Received: from 66-61-158-132.dialroam.rr.com ([66.61.158.132]:45835 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S261483AbUJZVnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:43:20 -0400
Date: Tue, 26 Oct 2004 17:37:04 -0400
From: jfannin1@columbus.rr.com
To: Alasdair G Kergon <agk@redhat.com>, Mathieu Segaud <matt@minas-morgul.org>,
       jfannin1@columbus.rr.com, Christophe Saout <christophe@saout.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, axboe@suse.de,
       bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
Message-ID: <20041026213703.GA6174@rivenstone.net>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Mathieu Segaud <matt@minas-morgul.org>, jfannin1@columbus.rr.com,
	Christophe Saout <christophe@saout.de>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, axboe@suse.de, bzolnier@gmail.com
References: <87oeitdogw.fsf@barad-dur.crans.org> <1098731002.14877.3.camel@leto.cs.pocnet.net> <20041026123651.GA2987@zion.rivenstone.net> <20041026135955.GA9937@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026135955.GA9937@agk.surrey.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 02:59:55PM +0100, Alasdair G Kergon wrote:
> On Tue, Oct 26, 2004 at 08:36:51AM -0400, jfannin1@columbus.rr.com wrote:
> > LVM doesn't work with 2.6.9-mm1 here either, complaining that it
> > can't find all the pv's. I'm not using any sort of encryption. Here,
> > pvdisplay reports:
> 
> > I can open the device nodes for the 'missing' pv's in a hexeditor and see the
> > uuid magic; if I reboot into 2.6.9-rc4-mm1 they are found without a
> > problem, and everything works.

> [To check for repeat of old problems with related symptoms:]
>   Were both kernels compiled with the same compiler version? Which version?
>   Does it make any difference if you rebuild lvm with --disable-o_direct?

    Chris Han (BCC'ed) mailed me to let me know he'd narrowed the
problem down to the 'dio-handle-eof.patch'.  Reverting it makes things
work for me too.  Yay!

> Firstly enable lvm debugging.  lvm.conf: log { file="/tmp/lvm2.log" level=7 }
> Compare the lvm log files for the kernels to see where it's going wrong.
> Then take complete straces (incl. read/write data) of the lvm process 
> with each kernel and again compare them. [Or put files on web and send URLs.]

vgchange -a y logs that it 'Failed to read label area' for the
'missing' pv's.

I've put up some possibly useful traces, but I think I've picked out
the relevant bits just below:
http://home.columbus.rr.com/jfannin1/vgchange-trace-good.txt
http://home.columbus.rr.com/jfannin1/vgchange-trace-bad.txt

Some (but not all) partitions opened are reading alternately (the -1024 is
constant): 

read(4, 0xbfffe600, 2048)               = ? ERESTARTSYS (To be restarted)
read(4, "\300;9\230", 2048)             = -1024

    If there's anything else that wants investigating, I'm still
willing as my free time allows.  Thanks!

-- 
Joseph Fannin
jfannin1@columbus.rr.com
