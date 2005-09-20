Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbVITS07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbVITS07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbVITS07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:26:59 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:6591 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S965057AbVITS06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:26:58 -0400
In-Reply-To: <20050920163848.GO7992@ftp.linux.org.uk>
References: <1127188015.17794.6.camel@vertex> <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org> <20050920042456.GC7992@ftp.linux.org.uk> <1127190971.18595.5.camel@vertex> <20050920044623.GD7992@ftp.linux.org.uk> <1127191992.19093.3.camel@vertex> <20050920045835.GE7992@ftp.linux.org.uk> <1127192784.19093.7.camel@vertex> <20050920051729.GF7992@ftp.linux.org.uk> <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org> <20050920163848.GO7992@ftp.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C6EA1BFF-119D-440D-81C0-3E1BC977A4B0@tentacle.dhs.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Content-Transfer-Encoding: 7bit
From: John McCutchan <ttb@tentacle.dhs.org>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Date: Tue, 20 Sep 2005 14:26:47 -0400
To: Al Viro <viro@ftp.linux.org.uk>
X-Mailer: Apple Mail (2.734)
X-PMX-Version-Mac: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.9.20.20
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Sep-05, at 12:38 PM, Al Viro wrote:
>
> I don't get it.  Could you please describe what your code is  
> _supposed_
> to do?  I'm not even talking about implementation - it's on the level
> of "what do we want the watchers to see after the following  
> operations".
> Especially since you have fixed ABI - if you have userland clients
> relying on the representation of individual events, surely they also
> have to assume something about the sequence of events generated when
> we do this and that to files and directories?
>

Okay here are some cases to help you get a better idea,

p1: watch /tmp/foo
p2: rm /tmp/foo

p1 gets IN_DELETE_SELF

p1: watch /tmp/foo
p2: echo > /tmp/foo

p1 gets IN_OPEN
p1 gets IN_MODIFY
p1 gets IN_CLOSE_WRITE

p1: watch /tmp
p2: rm /tmp/foo

p1 gets IN_DELETE + "foo"

p1: watch /tmp/foo
p2: unmount /tmp/

p1 gets IN_UNMOUNT
p1 gets IN_IGNORE

p1: watch /tmp/foo
p2 cat /tmp/foo

p1 gets IN_OPEN
p1 gets IN_ACCESS
p1 gets IN_CLOSE_NOWRITE

p1: watch /tmp/foo
p2: mv /tmp/foo /tmp/bar

p1 gets IN_MOVED_FROM + "foo" & IN_MOVED_TO + "bar"

p1: watch /tmp/
p2: echo > /tmp/bar

p1 gets IN_CREATE + "bar"
p1 gets IN_OPEN + "bar"
p1 gets IN_MODIFY + "bar"
p1 gets IN_CLOSE_WRITE + "bar"


John McCutchan
ttb@tentacle.dhs.org



