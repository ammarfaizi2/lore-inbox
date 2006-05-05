Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWEEPUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWEEPUI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWEEPUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:20:08 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:37025 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751129AbWEEPUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:20:06 -0400
Message-ID: <346842402.09691@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 5 May 2006 23:20:07 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Linda Walsh <lkml@tlinx.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060505152007.GB6134@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Linda Walsh <lkml@tlinx.org>, linux-kernel@vger.kernel.org
References: <346556235.24875@ustc.edu.cn> <44592491.4060503@tlinx.org> <346744728.01465@ustc.edu.cn> <445A4E91.1050802@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445A4E91.1050802@tlinx.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 11:57:21AM -0700, Linda Walsh wrote:
> Wu Fengguang wrote:
> >>   b) Be "dynamic"; "Trace" (record (dev&blockno/range) blocks
> >>starting ASAP after system boot and continuing for some "configurable"
> >>number of seconds past reaching the desired "run-level" (coinciding with
> >>initial disk quiescence).  Save as "configurable" (~6-8?) number of
> >>traces to allow finding the common initial subset of blocks needed.
> >>    
> >
> >It is a alternative way of doing the same job: more precise, with more
> >complexity and more overhead.  However the 'blockno' way is not so
> >tasteful.
> >  
> ----
> Maybe not so tasteful to you, but it is an alternate path that
> circumvents unnecessary i/o redirections.  An additional optimization

Yes, it's about the choice of the overhead/generalization that
indirections bring about.

> is to have a "cache" of frequently used "system applications" that have
> their pathnames registered, so no run-time seaching of the user PATH
> is necessary.

The facility is already there: it is called dcache.

> >I guess poor man's defrag would be good enough for the seeking storm.
> >  
> ---
>    I disagree. The "poor man's defrag, as you call it, puts entire files
> into contiguous sections -- each of which will have to be referenced by 
> following
> a PATH and directory chain.  The optimization I'm talking about would 
> only store
> the referenced data-blocks actually used in the files.  This would allow a
> directy read into memory of a *bunch* of needed sectors while not including
> sectors from the same files that are not actually read from during the 
> boot *or*
> app. initialization process.

The seek storm is mostly caused by small files(that are read in wholes),
and the corresponding scattered dir/inode buffers. By moving these
files to one single directory, both the file data/inode buffers are
kept continuous enough.

> ^** -- "somewhere", it _seems_, the physical, device relative sector
> must be resolved.  If it is not, how is i/o-block buffer consistency
> maintained when the user references "device "hda", sector "1000", then
> the same sector as "hda1", sector 500, and also as file "/etc/passwd",
> sector 0?  _If_ cache consistency is maintained (and I _assume_^**2
> it is), they all need to be mapped to a physical sector at some point.
> 
> ^**2 - Use of assumption noted; feel free to correct me and tell me
> this isn't the case if linux doesn't maintain disk-block cache
> consistency.

The linux cache model is something like:

                     physical drive             file /dev/hda1
                             | <-----------------> |         
file /bin/ls                 |                     |         
    |<---------------------> |                     |         
    |<---------------------> |                     |         
                             | <-----------------> |         
                             |                     |         
                             |                     |         
file /boot/vmlinuz           |                     |         
    |<---------------------> |                     |         
    |                        |                     |         
    |                        |                     |         
    |<---------------------> |                     |         
                             | <-----------------> |         
                             |                     |         
                             |                     |         
                             |                     |         

As opposed to this one:

                      file /dev/hda1         physical drive
                             | <-----------------> |         
file /bin/ls                 |                     |         
    |<---------------------> |                     |         
    |<---------------------> |                     |         
                             | <-----------------> |         
                             |                     |         
                             |                     |         
file /boot/vmlinuz           |                     |         
    |<---------------------> |                     |         
    |                        |                     |         
    |                        |                     |         
    |<---------------------> |                     |         
                             | <-----------------> |         
                             |                     |         
                             |                     |         
                             |                     |         

Wu
