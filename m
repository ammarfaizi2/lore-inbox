Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281313AbRKEU1U>; Mon, 5 Nov 2001 15:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281314AbRKEU1K>; Mon, 5 Nov 2001 15:27:10 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:15000 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281313AbRKEU1A>; Mon, 5 Nov 2001 15:27:00 -0500
Date: 05 Nov 2001 21:55:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8CG2BZMHw-B@khms.westfalen.de>
In-Reply-To: <20011104163354.C14001@unthought.net>
Subject: PROPOSAL: kernfs (was: Re: PROPOSAL: dot-proc interface [was: /proc st
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20011104163354.C14001@unthought.net>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jakob@unthought.net (Jakob ¥stergaard)  wrote on 04.11.01 in <20011104163354.C14001@unthought.net>:

> Here's my stab at the problems - please comment,
>
> We want to avoid these problems:
>  1)  It is hard to parse (some) /proc files from userspace
>  2)  As /proc files change, parsers must be changed in userspace
>
> Still, we want to keep on offering
>  3)  Human readable /proc files with some amount of pretty-printing
>  4)  A /proc fs that can be changed as the kernel needs those changes

And here's my proposal:

Backwards compatibility can be solved by keeping procfs as-is and creating  
a new kernfs. (Ok, so this could also be done as a sub-tree of proc, or  
any number of other ways ...)

The rest can be solved by defining a few generic file formats, and  
insisting (via the interfaces exposed to kernel code) that only those file  
formats will be used.

User space can further be helped by putting a format tag into the file  
name, if that is necessary - a single letter should be enough here.

As general design principles:

1. Most files should be plain text.

2. Text values should use the most obvious formatting. (Such as using  
10.1.2.3 for IP addresses, or 123.4 or 0.000234 for times in seconds.) If  
units are needed and SI has a base unit for that area, use it.

3. Any files that can be written to for control reasons, should have a  
single value and should read and write the same value. Unless it's a  
commando-type of interface, but those should be kept rare (and should  
probably read back some sort of status message). On read, there should be  
no white space or line ends around the value.

4. Only use binary if the subject matter doesn't make sense as text. I  
don't know that we actually have need for this - we certainly don't need  
another /proc/kcore, and firmware download drivers don't belong here.

5. I think I can see a use for two different table formats.

One has every line be a tag, a colon, optional white space around the  
colon and the tag, and a value; tags are unique, value formatting as in 2.  
UP /proc/cpuinfo, for example. Values can have embedded white space if  
that is necessary.

The other has a header line of white-space-separated tags, followed by  
lines of white-space-separated values, one per tag. No value should  
contain white space. /proc/net/rt_cache, for example.

6. There's a provision of having a list of similar directories indexed by  
either a number or a name, for per-blockdevice, per-channel, per-network- 
interface and so on.

Now, obviously, there'll be something I've missed ... but I think these  
are fairly sane design principles, and if we insist on everyone keeping to  
the defined formats and consider everything elkse a bug to be fixed, the  
result is easy to parse, easy to change without breaking sane parsers, and  
still human readable.

And we have made do with exactly three file formats, and could easily  
write a very small generic parser for these formats.

MfG Kai
