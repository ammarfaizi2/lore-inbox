Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317628AbSG2Sne>; Mon, 29 Jul 2002 14:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317640AbSG2Snd>; Mon, 29 Jul 2002 14:43:33 -0400
Received: from [195.223.140.120] ([195.223.140.120]:56422 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317628AbSG2Sna>; Mon, 29 Jul 2002 14:43:30 -0400
Date: Mon, 29 Jul 2002 20:47:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bob Miller <rem@osdl.org>
Cc: Daniel McNeil <daniel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 i_size atomic access
Message-ID: <20020729184758.GW1201@dualathlon.random>
References: <1026949132.20314.0.camel@joe2.pdx.osdl.net> <1026951041.2412.38.camel@IBM-C> <20020718103511.GG994@dualathlon.random> <1027037361.2424.73.camel@IBM-C> <20020719112305.A15517@oldwotan.suse.de> <1027119396.2629.16.camel@IBM-C> <20020723170807.GW1116@dualathlon.random> <20020723174712.GB1117@dualathlon.random> <20020729113730.A18687@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729113730.A18687@doc.pdx.osdl.net>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 11:37:30AM -0700, Bob Miller wrote:
> On Tue, Jul 23, 2002 at 07:47:12PM +0200, Andrea Arcangeli wrote:
> > On Tue, Jul 23, 2002 at 07:08:07PM +0200, Andrea Arcangeli wrote:
> > > So while merging it I rewrote it this way (I also change the type of the
> > 
> > here it is the final full patch:
> > 
> 
> Stuff deleted...
> 
> > diff -urNp race/include/asm-i386/system.h race-fix/include/asm-i386/system.h
> > --- race/include/asm-i386/system.h	Tue Jul 23 18:46:44 2002
> > +++ race-fix/include/asm-i386/system.h	Tue Jul 23 18:47:10 2002
> > @@ -143,6 +143,8 @@ struct __xchg_dummy { unsigned long a[10
> >  #define __xg(x) ((struct __xchg_dummy *)(x))
> >  
> >  
> > +#ifdef CONFIG_X86_CMPXCHG
> > +#define __ARCH_HAS_GET_SET_64BIT 1
> >  /*
> >   * The semantics of XCHGCMP8B are a bit strange, this is why
> >   * there is a loop and the loading of %%eax and %%edx has to
> > @@ -167,7 +169,7 @@ static inline void __set_64bit (unsigned
> >  		"lock cmpxchg8b (%0)\n\t"
> >  		"jnz 1b"
> >  		: /* no outputs */
> > -		:	"D"(ptr),
> > +		:	"r"(ptr),
> >  			"b"(low),
> >  			"c"(high)
> >  		:	"ax","dx","memory");
> > @@ -197,6 +199,32 @@ static inline void __set_64bit_var (unsi
> >   __set_64bit(ptr, (unsigned int)(value), (unsigned int)((value)>>32ULL) ) : \
> >   __set_64bit(ptr, ll_low(value), ll_high(value)) )
> >  
> 
> Stuff deleted...
> >  
> > +/*
> > + * NOTE: in a 32bit arch with a preemptable kernel and
> > + * an UP compile the i_size_read/write must be atomic
> > + * with respect to the local cpu (unlike with preempt disabled),
> > + * but they don't need to be atomic with respect to other cpus like in
> > + * true SMP (so they need either to either locally disable irq around
> > + * the read or for example on x86 they can be still implemented as a
> > + * cmpxchg8b without the need of the lock prefix). For SMP compiles
> > + * and 64bit archs it makes no difference if preempt is enabled or not.
> > + */
> > +static inline loff_t i_size_read(struct inode * inode)
> > +{
> > +#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
> > +#ifdef __ARCH_HAS_GET_SET_64BIT
> > +	return (loff_t) get_64bit((unsigned long long *) &inode->i_size);
> > +#else
> > +	loff_t i_size;
> > +	int v1, v2;
> > +
> > +	/* Retry if i_size was possibly modified while sampling. */
> > +	do {
> > +		v1 = inode->i_size_version1;
> > +		rmb();
> > +		i_size = inode->i_size;
> > +		rmb();
> > +		v2 = inode->i_size_version2;
> > +	} while (v1 != v2);
> > +
> > +	return i_size;
> > +#endif
> > +#elif BITS_PER_LONG==64 || !defined(CONFIG_SMP)
> > +	return inode->i_size;
> > +#endif
> > +}
> > +
> 
> Andrea,
> 
> Sorry for responding to this thread so late (I have been on holiday)...
> I don't like creating __ARCH_HAS_GET_SET_64BIT and then doing conditional
> code based on it.  I believe that get_64bit() and set_64bit() should
> always be defined and used.  On x86 with cmpxchg8b and SMP or PREEMPT
> get_64bit() and set_64bit() use cmpxchg8b.  On 386 and 486 with SMP
> or PREEMPT create "safe" versions i.e.:
> 
> static inline void set_64bit(unsigned long long * ptr, unsigned long long value)
> {
> 	lock_kernel();
> 	*ptr = value;
> 	unlock_kernel();
> }
> 
> static inline unsigned long long get_64bit(unsigned long long * ptr)
> {
> 	unsigned long long retval;
> 
> 	lock_kernel();
> 	retval = *ptr;
> 	unlock_kernel
> 
> 	return reval;
> }
> 
> I know BKL sucks but how many SMP/PREEMPT 386/486 boxes are really out there?
> 
> And for all non SMP or PREEMPT do:
> 
> static inline void set_64bit(unsigned long long * ptr, unsigned long long value)
> {
> 	*ptr = value;
> }
> 
> static inline unsigned long long get_64bit(unsigned long long * ptr)
> {
> 	return *ptr;
> }
> 
> Other arches are free to do the "right thing" for them selfs.

well, the point are exactly the other archs, i.e. s390. Why should s390
lose total scalability during read/writes with a big kernel lock or
similar, when they can use the ordered version? (maybe it's even
possible to read/write 64bit atomically on s390 like we do on 586+, but
still some 32bit arch may not provide that functionality and they
will definitely prefer the ordered read/write using sequence numbers
rather than a big kernel lock or global lock) That's the whole point of
the __ARCH_HAS_GET_SET_64BIT information.

Andrea
