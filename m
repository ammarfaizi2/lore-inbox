Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSLZNpg>; Thu, 26 Dec 2002 08:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSLZNpg>; Thu, 26 Dec 2002 08:45:36 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:22435 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261486AbSLZNpf>;
	Thu, 26 Dec 2002 08:45:35 -0500
Message-ID: <3E0B09E4.6010708@colorfullife.com>
Date: Thu, 26 Dec 2002 14:53:40 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: anton@samba.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5 fast poll on ppc64
References: <200212261257.NAA02448@harpo.it.uu.se>
In-Reply-To: <200212261257.NAA02448@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:

>Anton Blanchard writes:
> > I was unable to boot 2.5-BK on ppc64 and narrowed it down to the fast
> > poll patch.  I found:
> > 
> > offsetof(struct poll_list, entries) == 12 but
> > sizeof(struct poll_list) == 16
> > 
> > This means pp+1 did not match up with pp->entries. Im not sure what the
> > alignment requirements are for a zero length struct (ie is this a
> > compiler bug) but the following patch fixes the problem and also changes
> > ->len to a long to ensure 8 byte alignment of ->entries on 64bit archs.
> > 
> > Anton
> > 
> > ===== fs/select.c 1.15 vs edited =====
> > --- 1.15/fs/select.c	Sat Dec 21 20:42:41 2002
> > +++ edited/fs/select.c	Thu Dec 26 17:31:16 2002
> > @@ -362,7 +362,7 @@
> >  
> >  struct poll_list {
> >  	struct poll_list *next;
> > -	int len;
> > +	long len;
> >  	struct pollfd entries[0];
> >  };
>
>To me (I'm a compiler writer) it looks like your compiler did NOT
>mess up. Assuming struct pollfd has 32-bit alignment, the compiler
>is doing the right thing by starting entries[] at offset 12.
>The 16-byte size for struct poll_list is because the 'next' field
>has 64-bit alignment, which forces the compiler to pad struct
>poll_lists's size to a multiple of 8 bytes, i.e. 16 bytes in this
>case. So the compiler is not broken.
>  
>
I would agree, but there is a special restriction on offsetof() and 
sizeof() of structures with flexible array members: section 6.7.2.1, 
clause 16:

First, the size of the structure shall be equal to the offset of the last element of an otherwise identical structure that replaces the flexible array member with an array of unspecified length.

The simplest test case I've found is

struct a1 { int a; char b; short c[];};
struct a2 { int a; char b; short c[1];};

    sizeof(struct a{1,2}) is 8.
    offsetof(struct a{1,2}, c) is 6.

--> sizeof(struct a1) != offsetof(struct a2, c)

> >  
> > @@ -471,7 +471,7 @@
> >  			walk->next = pp;
> >  
> >  		walk = pp;
> > -		if (copy_from_user(pp+1, ufds + nfds-i, 
> > +		if (copy_from_user(pp->entries, ufds + nfds-i, 
> >  				sizeof(struct pollfd)*pp->len)) {
>
>But the old code which assumed pp+1 == pp->entries is so horribly
>broken I can't find words for it. s/pp+1/pp->entries/ is the correct fix.
>  
>
I agree. Should we fix the kmalloc allocations, too?

-	pp = kmalloc(sizeof(struct poll_list)+
+	pp = kmalloc(offsetof(struct poll_list,entries)+
			sizeof(struct pollfd)*
			(i>POLLFD_PER_PAGE?POLLFD_PER_PAGE:i),
				GFP_KERNEL);


--
    Manfred

