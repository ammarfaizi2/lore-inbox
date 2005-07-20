Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVGTPdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVGTPdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 11:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVGTPdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 11:33:31 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:19954 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261387AbVGTPda convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 11:33:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WVV71dgIj/YSFWK9Xfw531ZECxA/goopywOBS8AkJu2aQaMvpYuq8S5Zicv2DlOnv302XFKOzO3t+VrQohH5zE0iJvO243Yc9N20fMG+Yg135BdTDtp45s49/YgTy7N7JwyyA/HmdXvVxVEwKo713ADqSjsf/qaYyG65qstmn+g=
Message-ID: <3f250c7105072008321c128deb@mail.gmail.com>
Date: Wed, 20 Jul 2005 11:32:55 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: "P@draigbrady.com" <P@draigbrady.com>
Subject: Re: How do you accurately determine a process' RAM usage?
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42DE60D8.2070101@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42CC2923.2030709@draigBrady.com>
	 <20050706181623.3729d208.akpm@osdl.org>
	 <42CCE737.70802@draigBrady.com>
	 <20050707014005.338ea657.akpm@osdl.org>
	 <42D39102.5010503@draigBrady.com>
	 <3f250c7105071913091c5b2858@mail.gmail.com>
	 <42DE60D8.2070101@draigBrady.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brady,

On 7/20/05, P@draigbrady.com <P@draigbrady.com> wrote:
> Mauricio Lin wrote:
> > Hi,
> >
> > On 7/12/05, P@draigbrady.com <P@draigbrady.com> wrote:
> >
> >>Andrew Morton wrote:
> >>
> >>>OK, please let us know how it goes.
> >>
> >>It went very well. I could find no problems at all.
> >>I've updated my script to use the new method, so please merge smaps :)
> >>http://www.pixelbeat.org/scripts/ps_mem.py
> >>
> >>Usually the shared mem reported by /proc/$$/statm
> >>is the same as summing all the shared values in in /proc/$$/smaps
> >>but there can be large discrepancies.
> >
> >
> > Have you checked how the statm shared is calculated? I guess it does
> > something like:
> > shared = mm->rss - mm->anon_rss
> 
> yes
> 
> > But in smaps output you can have anonymous area like:
> >
> > b6e0e000-b6e13000 rw-p
> > Size:                20 KB
> > Rss:                  4 KB
> > Shared_Clean:         0 KB
> > Shared_Dirty:         4 KB
> > Private_Clean:        0 KB
> > Private_Dirty:        0 KB
> >
> > Look that it presents 4 KB of shared value in area considered anonymous.
> >
> > ANDREW: anon_rss is the rss for anonymous area, right?
> 
> I see your point and I'm not sure.
> The following shell gets the shared values for the
> first httpd process:
> 
> FIRST_HTTPD=`ps -C httpd -o pid= | head -1 | tr -d ' '`
> HTTPD_STATM_SHARED=$(expr 4 '*' `cut -f3 -d' ' /proc/$FIRST_HTTPD/statm`)
> HTTPD_SMAPS_SHARED=$(grep Shared /proc/$FIRST_HTTPD/smaps | tr -s ' '
> | cut -f2 -d' ' | ( tr '\n' +; echo 0 ) | bc)
> 
> 
> This shows that "smaps" reports 3060 KB more shared mem than "statm".
> However adding up all the anon sections in smaps only gives 2456 KB?

You are adding up all Shared_Clean and Shared_Dirty as Shared, right?

> 
> When doing this I also noticed that there are duplicate
> entries in smaps. Any ideas why?

Each pair of address per line indicates the start and end address of a
memory area (VMA) such as:

b7f7d000-b7f7e000 

This means that an specific memory area start on virtual address 
b7f7d000 and end on b7f7e000 .

An mapped file like /lib/ld-2.3.3.so is organized in different memory
areas. The memory area can be a text section, data section or bss. So
it is normal you find the same filename mapped in more than one memory
area.

You can find more information about VMA on Linux Kernel Development
book (chapter 14) written by Robert Love.

For instance:

> grep -F - /proc/$FIRST_HTTPD/smaps | sort | uniq -d -c
> 
>        2 b7f7d000-b7f7e000 r-xp 00000000 03:05 246646
> /usr/lib/httpd/modules/mod_auth_anon.so
This is a text section.

>        2 b7f7e000-b7f7f000 rwxp 00000000 03:05 246646
> /usr/lib/httpd/modules/mod_auth_anon.so
This should be a data section.

IMHO, bss section corresponds to the anonymous area where the mapping
is not backed by a file.

BR,

Mauricio Lin.
