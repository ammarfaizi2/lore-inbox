Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280735AbRKGBcf>; Tue, 6 Nov 2001 20:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280731AbRKGBc0>; Tue, 6 Nov 2001 20:32:26 -0500
Received: from ns.suse.de ([213.95.15.193]:52229 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280727AbRKGBcU>;
	Tue, 6 Nov 2001 20:32:20 -0500
Date: Wed, 7 Nov 2001 02:32:18 +0100
From: Andi Kleen <ak@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, acl-devel@bestbits.at,
        linux-xfs@oss.sgi.comc
Subject: Re: [RFC][PATCH] extended attributes
Message-ID: <20011107023218.A4754@wotan.suse.de>
In-Reply-To: <20011107111224.C591676@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011107111224.C591676@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Wed, Nov 07, 2001 at 11:12:24AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 11:12:24AM +1100, Nathan Scott wrote:
> A manual page describing the system call interface can be found here[4].
> We're very interested in feedback on this.  In partiular, Linus - would

The cursor support looks quite complicated. It doesn't even forbid 
storing the contents of the cursor buffer somewhere and has all
the standard problems with stateless cursors requiring nasty hacks
with dynamic data structures with parallel modification.
Stateless cursors are just nasty!

I think it would be better to have a statefull readdir instead.
The kernel supports it via the ->private_data field of struct file
(not through fork,but that looks like a generic vfs bug) 

EA_FIRST_ENTRY to reset the fd the first entry, EA_READ_ENTRY to 
read the next one.

It would not be inherently thread safe, but also not be worse
in this regard than standard readdir (requiring user locks)

It would also be possible to do a threadsafe interface although it would be 
a bit uglier: EA_GET_LISTSIZE to get the 
size of the buffer required, EA_GET_FULL_LIST to fetch a full
buffer with the names of all EAs, EAGAIN on race.

I think doing it in one of these ways would be far easier for the
user and easier for future kernel implementations.

-Andi
