Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbWIVWki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbWIVWki (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbWIVWkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:40:37 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:17710 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S965234AbWIVWkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:40:35 -0400
Subject: Re: [Kgdb-bugreport] compiling kernel with -O0 flag (For optimal
	debugging with kgdb and/or crash).
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: emin ak <eminak71@gmail.com>
Cc: Piet Delaney <piet@bluelane.com>, Kgdb-bugreport@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, crash-utility@redhat.com,
       Subhachandra Chandra <schandra@bluelane.com>
In-Reply-To: <2cf1ee820609211354m3ae2ec5btc7274402d84b5400@mail.gmail.com>
References: <2cf1ee820609211354m3ae2ec5btc7274402d84b5400@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VJkE19jisQRzOXrCDCEr"
Organization: Blue Lane Technologies
Date: Fri, 22 Sep 2006 15:40:29 -0700
Message-Id: <1158964829.32095.136.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
X-OriginalArrivalTime: 22 Sep 2006 22:40:33.0555 (UTC) FILETIME=[1D5B3630:01C6DE98]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VJkE19jisQRzOXrCDCEr
Content-Type: multipart/mixed; boundary="=-kZrm55j35RwuwrrkWzYs"


--=-kZrm55j35RwuwrrkWzYs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-09-21 at 23:54 +0300, emin ak wrote:
> Dear All;
> Firstly thank you very much for your great effort for kgdb that makes
> kernel much understandable.
> I'am using kgdb to debug tcp-ip stack but I have experienced serious
> difficulties while debugging inline functions.

Hi Emin:

Yep, I edit "static inline" to "static_inline" and then define
static_inline as static for KGDB kernels.

In include/linux/compiler-gcc3.h and include/linux/compiler-gcc4.h
I added:
------------------------------------------------------------------
#if defined(CONFIG_KGDB) || defined(CONFIG_KEXEC)
# define static_inline    static __attribute__ ((__unused__))
# define static__inline__ static __attribute__ ((__unused__))
# define INLINE                  __attribute__ ((__unused__))
# define __INLINE__              __attribute__ ((__unused__))
#else
# define static_inline      static   inline
# define static__inline__   static __inline__
# define INLINE                      inline
# define __INLINE__                __inline__
#endif
----------------------------------------------------------------------
I'm using it today to understand the device mapping and encryption code.
It's great! Inline's make skipping over code with the gdb 'next'
instruction impossible and you can't see the local variables.=20

I like having a large stack, compiling -O0 and without inlines
can increase the stack size. I think I notices more stability
by adding this to include/asm-i386/thread_info.h:
----------------------------------------------------------------------
#if defined(CONFIG_DEBUG_PREEMPT_AUDIT) || defined(CONFIG_KGDB) ||
defined(CONFIG_KEXEC)
#define THREAD_SIZE     (8192 * 2)
#else
#ifdef CONFIG_4KSTACKS
#define THREAD_SIZE     (4096)
#else
#define THREAD_SIZE     (8192)
#endif
#endif
-----------------------------------------------------------------------

Without OPTIMIZATION I found the MMU code needs a tweak
in../linux-4/mm/memory.c:
------------------------------------------------------------------------
#if !defined(__PAGETABLE_PUD_FOLDED) || defined(CONFIG_KGDB) ||
defined(CONFIG_KEXEC)
/*
 * Allocate page upper directory.
 *
 * We've already handled the fast-path in-line, and we own the
 * page table lock.
 */
pud_t fastcall *__pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned
long address)
{
.
.
.
}
#if !defined(__PAGETABLE_PMD_FOLDED) || defined(CONFIG_KGDB) ||
defined(CONFIG_KEXEC)
/*
 * Allocate page middle directory.
 *
 * We've already handled the fast-path in-line, and we own the
 * page table lock.
 */
pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned
long address)
{
.
.
}
---------------------------------------------------------------------------

Maybe I should have used #if !defined(__OPTIMIZE__)
in ../linux-4/mm/memory.c. Another change is I needed
to define a few network byte swapping functions. I currently
define them in ../linux-4/net/core/sock.c but I'm not
resistant to putting it in a better place:
---------------------------------------------------------------------------=
-
/*
 * If compiling -O0 we need to define
 * these functions somewhere.
 */
#if !defined(__OPTIMIZE__)
#define ___htonl(x) __cpu_to_be32(x)
#define ___htons(x) __cpu_to_be16(x)
#define ___ntohl(x) __be32_to_cpu(x)
#define ___ntohs(x) __be16_to_cpu(x)

__u32  htonl(__be32 x) { return(___htonl(x)); }
__u32  ntohl(__be32 x) { return(___ntohl(x)); }
__be16 htons(__u16 x)  { return(___htons(x)); }
__u16  ntohs(__be16 x) { return(___ntohs(x)); }

EXPORT_SYMBOL(htonl);
EXPORT_SYMBOL(ntohl);
EXPORT_SYMBOL(htons);
EXPORT_SYMBOL(ntohs);
#endif
---------------------------------------------------------------------------=
---

Sometimes I only want to compile the tcp/ip code -O0, so I modified the
networking Makefiles and added:

---------------------------------------------------------------------------=
----
ifdef CONFIG_KGDB
CFLAGS +=3D -gdwarf-2 -O0
else
ifdef CONFIG_KEXEC
CFLAGS +=3D -gdwarf-2 -O0
endif
endif
---------------------------------------------------------------------------=
---

In the top level kernel Makefile I have:
---------------------------------------------------------------------------=
---
ifdef CONFIG_FRAME_POINTER
CFLAGS      +=3D -fno-omit-frame-pointer
else
CFLAGS      +=3D -fomit-frame-pointer
endif

#
# Compiling the complete kernel without optimization (-O0) for enhanced
debugging
# with kgdb/kdump requires ./mm/memory.c to have:
#
#       if !defined(__PAGETABLE_PUD_FOLDED) || defined(CONFIG_KGDB) ||
defined(CONFIG_KEXEC)
# and
#       if !defined(__PAGETABLE_PMD_FOLDED) || defined(CONFIG_KGDB) ||
defined(CONFIG_KEXEC)
#
# A less invasive procedure is to use -O1 and only use -O0 for
networking code.
# The networking Makefiles have been setup to support this. So just
change
# -O0 to -O1 below and back out the kgdb change in ./mm/memory.c for a
# less invasive change. Compiling -O0 also required increasing
ROUNDUP_WAIT in
# linux/kernel/kgdb.c; value in 2.6.12 patch was way to low and value in
2.6.16
# is marginal and frequently causes lead CPU to times out prematurely
waiting for
# other CPU's to stop.
#
ifdef CONFIG_DEBUG_INFO
ifdef CONFIG_KGDB
CFLAGS      +=3D -gdwarf-2 -O0
else
ifdef CONFIG_KEXEC
CFLAGS      +=3D -gdwarf-2 -O1
else
CFLAGS      +=3D -g
endif
endif
endif
---------------------------------------------------------------------------=
---------


>                                                 I know this is not a
> bug but with -O optimizations and inlines on tcp-ip stack, program
> counter goes everywhere madly even with step or next command and this
> makes debugging incomprehensible.

Yep, I don't understand why everyone else doesn't. It's also=20
like using debug printf's, I like being able to trace the code=20
to get the big picture and then a -O0 to look at details with kgdb.

Some believe doing this kind of stuff is blasphemy. The
Bible says I should be killed for working on Sunday; I
happen to disagree.


>                              At this point I have two questions:
> 1- Is there any way to compile kernel with -O0 flag and if it's
> possible, may it cause any problems?

I offered to post them to Amit back on Sept 06(2:45 PM) but I don't
think I ever heard back. I'd prefer to see the -O0 and KGDB_DEBUG
code for tracing the kgdb stub assimilated. If they would be accepted
I could make a patch to Tom's git repository...

> 2- Why does kernel fail while compiling with O0 flag and why does
> linux kernel depends on inline functions so much?

I think it's an obsession with performance. As long as I/we can map
"static inline" to "static" it's not a big deal.

>                                                     Is there anyone
> whoever uses kgdb for debugging linux tcp-ip stack or any effort to
> compile kernel with no optimization?

I'm using it every day; works great. I also recommend by SOCK_DEBUG,
SKB_DEBUG, and TCP_DEBUG macros to trace the TCP code. I also indent
the trace to make it easy to read.

	function1() {
		function2() {
			function3() {
				function4();
			}
		}
	}

The brackets make it easy to see the scope of the trace with vi.
I like tracing with 'C' syntax since it what the reader is use to.
If folks are interested I could also add that to the git diff, but
I think that likely belongs else where and isn't likely the current
dogma. See snippet from attached network trace. I gave a talk
at a UNENIX conference back in the 1980 recommending a common UNIX
tracing paradigm and a few liked it. The director of Siemens,
Struck  Zimmerman, didn't; you can't please everyone, so I just do what
I think is best and live with the world not being as I'd expect it to
be.

For TCP I'm using the attached sock.h fragment which has a=20
backward compatible SOCK_DEBUG() macro. I used the same paradigm in
skbuff.h; see attachment. Likewise I'm doing the same in kgdb.h; also
attached.

In printk I added:
--------------------------------------------------------------------

                for (tp =3D tbuf; tp < tbuf + tlen; tp++)
                    emit_log_char(*tp);
                printed_len +=3D tlen - 3;
#ifdef CONFIG_PRINTK_INDENT
                if (!in_interrupt()) {
                    int depth =3D stack_depth();
                    int i;

                    if ((depth > 0) && (depth < 120)) {
                        for(i =3D 0; i < depth; i++) {
                        emit_log_char(' ');
                        printed_len++;
                        }
                    }
                }
#endif
-----------------------------------------------------------

and I added stack_depth() function
to  ../linux-4/arch/i386/kernel/traps.c
-----------------------------------------------------------
int stack_depth(void)
{
    struct thread_info *tinfo;
    unsigned long ebp;
    int depth =3D 0;

#ifdef  CONFIG_FRAME_POINTER
    asm("andl %%esp,%0; ":"=3Dr" (tinfo) : "0" (~(THREAD_SIZE - 1)));
    asm ("movl %%ebp, %0" : "=3Dr" (ebp) : );

     while (valid_stack_ptr(tinfo, (void *)ebp)) {
        ebp =3D *(unsigned long *)ebp;
        if (depth++ > 100) {
             break;
        }
    }
#endif
    return(depth);
}
---------------------------------------------------------------------------

Let me know if you you have any questions. Sounds like your on the right
track; IMHO.

-piet

>=20
> Thanks alot.
> Emin
>=20
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Kgdb-bugreport mailing list
> Kgdb-bugreport@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport
--=20
Piet Delaney                                    Phone: (408) 200-5256
Blue Lane Technologies                          Fax:   (408) 200-5299
10450 Bubb Rd.
Cupertino, Ca. 95014                            Email: piet@bluelane.com

--=-kZrm55j35RwuwrrkWzYs
Content-Disposition: attachment; filename=kgdb.h
Content-Type: text/x-chdr; name=kgdb.h; charset=iso-8859-1
Content-Transfer-Encoding: base64

LyoNCiAqIGluY2x1ZGUvbGludXgva2dkYi5oDQogKg0KICogVGhpcyBwcm92aWRlcyB0aGUgaG9v
a3MgYW5kIGZ1bmN0aW9ucyB0aGF0IEtHREIgbmVlZHMgdG8gc2hhcmUgYmV0d2Vlbg0KICogdGhl
IGNvcmUsIEkvTyBhbmQgYXJjaC1zcGVjaWZpYyBwb3J0aW9ucy4NCiAqDQogKiBBdXRob3I6IEFt
aXQgS2FsZSA8YW1pdGthbGVAbGluc3lzc29mdC5jb20+IGFuZA0KICogICAgICAgICBUb20gUmlu
aSA8dHJpbmlAa2VybmVsLmNyYXNoaW5nLm9yZz4NCiAqDQogKiAyMDAxLTIwMDQgKGMpIEFtaXQg
Uy4gS2FsZSBhbmQgMjAwMy0yMDA0IChjKSBNb250YVZpc3RhIFNvZnR3YXJlLCBJbmMuDQogKiBU
aGlzIGZpbGUgaXMgbGljZW5zZWQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZQ0KICogdmVyc2lvbiAyLiBUaGlzIHByb2dyYW0gaXMgbGljZW5zZWQgImFz
IGlzIiB3aXRob3V0IGFueSB3YXJyYW50eSBvZiBhbnkNCiAqIGtpbmQsIHdoZXRoZXIgZXhwcmVz
cyBvciBpbXBsaWVkLg0KICovDQojaWZkZWYgX19LRVJORUxfXw0KI2lmbmRlZiBfS0dEQl9IXw0K
I2RlZmluZSBfS0dEQl9IXw0KDQojaW5jbHVkZSA8YXNtL2F0b21pYy5oPg0KDQojaWZkZWYgQ09O
RklHX0tHREINCiNpbmNsdWRlIDxhc20va2dkYi5oPg0KI2luY2x1ZGUgPGxpbnV4L3NlcmlhbF84
MjUwLmg+DQojaW5jbHVkZSA8bGludXgvbGlua2FnZS5oPg0KDQpzdHJ1Y3QgdGFza2xldF9zdHJ1
Y3Q7DQpzdHJ1Y3QgcHRfcmVnczsNCnN0cnVjdCB0YXNrX3N0cnVjdDsNCnN0cnVjdCB1YXJ0X3Bv
cnQ7DQoNCg0KLyogVG8gZW50ZXIgdGhlIGRlYnVnZ2VyIGV4cGxpY2l0bHkuICovDQojaWYgZGVm
aW5lZChDT05GSUdfVlBST1hZKSB8fCBkZWZpbmVkKENPTkZJR19DUllQVE9fREVWX0NBVklVTV9O
SVRST1gpDQpleHRlcm4gdm9pZCBrZ2RiX2JwKHZvaWQpOw0KZXh0ZXJuIHZvaWQgYnAodm9pZCk7
DQojZW5kaWYNCg0Kc3RhdGljIGlubGluZSBpbnQga2dkYl9mdW5jdGlvbl9lbnRyeShjb25zdCBj
aGFyICpmbXQsIC4uLikNCnsNCgkJcmV0dXJuKGZtdFswXSA9PSAnKCcpOw0KfQ0KDQojZGVmaW5l
IEtHREJfREVCVUdJTkcNCiNpZmRlZiBLR0RCX0RFQlVHSU5HDQojIGRlZmluZSBLR0RCX01BWF9M
RVZFTCAxMAkJLyogTWF4IExldmVsIHRvIGNvbXBpbGUgaW4gKi8NCiMgZGVmaW5lIEtHREJfREVC
VUcobGV2ZWwsIG1zZy4uLikgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcDQogICAgICAgIGRvIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgIGlmIChsZXZl
bCA8PSBLR0RCX01BWF9MRVZFTCAmJiBsZXZlbCA8PSBrZ2RiX2RlYnVnKSB7ICAgICAgICAgIFwN
CiAgICAgICAgICAgICAgICAgICAgaW50IGNwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAg
ICAgICAgICAgICAgICBzcGluX2xvY2soJmtnZGJfcHJpbnRmX2xvY2spOyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAgaWYgKGtnZGJfZnVuY3Rpb25f
ZW50cnkobXNnKSkgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAg
ICAgICAgICAgICBwcmludGsoS0VSTl9FUlIgIjxjcHU6JWQ+ICVzIiwgY3B1LCBfX2Z1bmNfXyk7
ICAgICAgICAgXA0KICAgICAgICAgICAgICAgICAgICB9IGVsc2UgeyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAg
ICAgIHByaW50ayhLRVJOX0VSUiAiPGNwdTolZD4gJXM6ICIsIGNwdSwgX19mdW5jX18pOyAgICAg
ICBcDQogICAgICAgICAgICAgICAgICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgICAgICBwcmludGso
bXNnKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAg
ICAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2soJmtnZGJfcHJpbnRmX2xvY2spOyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAgfSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICB9
IHdoaWxlICgwKQ0KDQpleHRlcm4gdm9sYXRpbGUgaW50IGtnZGJfZGVidWc7ICAgICAvKiBEZWJ1
ZyBsZXZlbDsgbGlrZSBnZGIgc2V0IGRlYnVnIHJlbW90ZSAnbicgKi8NCmV4dGVybiBzcGlubG9j
a190IGtnZGJfcHJpbnRmX2xvY2s7DQojZWxzZQ0KIyBkZWZpbmUgS0dEQl9ERUJVRyhsZXZlbCwg
bXNnLi4uKSBkbyB7IH0gd2hpbGUgKDApDQojZW5kaWYNCg0KZXh0ZXJuIHZvaWQgYnJlYWtwb2lu
dCh2b2lkKTsNCmV4dGVybiBpbnQga2dkYl9jb25uZWN0ZWQ7DQpleHRlcm4gaW50IGtnZGJfbWF5
X2ZhdWx0Ow0KZXh0ZXJuIHN0cnVjdCB0YXNrbGV0X3N0cnVjdCBrZ2RiX3Rhc2tsZXRfYnJlYWtw
b2ludDsNCg0KZXh0ZXJuIGF0b21pY190IGtnZGJfc2V0dGluZ19icmVha3BvaW50Ow0KZXh0ZXJu
IGF0b21pY190IGNwdV9kb2luZ19zaW5nbGVfc3RlcDsNCg0KZXh0ZXJuIHN0cnVjdCB0YXNrX3N0
cnVjdCAqa2dkYl91c2V0aHJlYWQsICprZ2RiX2NvbnR0aHJlYWQ7DQoNCmVudW0ga2dkYl9icHR5
cGUgew0KCWJwX2JyZWFrcG9pbnQgPSAnMCcsDQoJYnBfaGFyZHdhcmVfYnJlYWtwb2ludCwNCgli
cF93cml0ZV93YXRjaHBvaW50LA0KCWJwX3JlYWRfd2F0Y2hwb2ludCwNCglicF9hY2Nlc3Nfd2F0
Y2hwb2ludA0KfTsNCg0KZW51bSBrZ2RiX2Jwc3RhdGUgew0KCWJwX2Rpc2FibGVkLA0KCWJwX2Vu
YWJsZWQNCn07DQoNCnN0cnVjdCBrZ2RiX2JrcHQgew0KCXVuc2lnbmVkIGxvbmcgYnB0X2FkZHI7
DQoJdW5zaWduZWQgY2hhciBzYXZlZF9pbnN0cltCUkVBS19JTlNUUl9TSVpFXTsNCgllbnVtIGtn
ZGJfYnB0eXBlIHR5cGU7DQoJZW51bSBrZ2RiX2Jwc3RhdGUgc3RhdGU7DQp9Ow0KDQovKiBUaGUg
bWF4aW11bSBudW1iZXIgb2YgS0dEQiBJL08gbW9kdWxlcyB0aGF0IGNhbiBiZSBsb2FkZWQgKi8N
CiNkZWZpbmUgTUFYX0tHREJfSU9fSEFORExFUlMgMw0KDQojaWZuZGVmIE1BWF9CUkVBS1BPSU5U
Uw0KI2RlZmluZSBNQVhfQlJFQUtQT0lOVFMJCTE2DQojZW5kaWYNCg0KI2RlZmluZSBLR0RCX0hX
X0JSRUFLUE9JTlQJMQ0KDQovKiBSZXF1aXJlZCBmdW5jdGlvbnMuICovDQovKioNCiAqCXJlZ3Nf
dG9fZ2RiX3JlZ3MgLSBDb252ZXJ0IHB0cmFjZSByZWdzIHRvIEdEQiByZWdzDQogKglAZ2RiX3Jl
Z3M6IEEgcG9pbnRlciB0byBob2xkIHRoZSByZWdpc3RlcnMgaW4gdGhlIG9yZGVyIEdEQiB3YW50
cy4NCiAqCUByZWdzOiBUaGUgJnN0cnVjdCBwdF9yZWdzIG9mIHRoZSBjdXJyZW50IHByb2Nlc3Mu
DQogKg0KICoJQ29udmVydCB0aGUgcHRfcmVncyBpbiBAcmVncyBpbnRvIHRoZSBmb3JtYXQgZm9y
IHJlZ2lzdGVycyB0aGF0DQogKglHREIgZXhwZWN0cywgc3RvcmVkIGluIEBnZGJfcmVncy4NCiAq
Lw0KZXh0ZXJuIHZvaWQgcmVnc190b19nZGJfcmVncyh1bnNpZ25lZCBsb25nICpnZGJfcmVncywg
c3RydWN0IHB0X3JlZ3MgKnJlZ3MpOw0KDQovKioNCiAqCXNsZWVwaW5nX3JlZ3NfdG9fZ2RiX3Jl
Z3MgLSBDb252ZXJ0IHB0cmFjZSByZWdzIHRvIEdEQiByZWdzDQogKglAZ2RiX3JlZ3M6IEEgcG9p
bnRlciB0byBob2xkIHRoZSByZWdpc3RlcnMgaW4gdGhlIG9yZGVyIEdEQiB3YW50cy4NCiAqCUBw
OiBUaGUgJnN0cnVjdCB0YXNrX3N0cnVjdCBvZiB0aGUgZGVzaXJlZCBwcm9jZXNzLg0KICoNCiAq
CUNvbnZlcnQgdGhlIHJlZ2lzdGVyIHZhbHVlcyBvZiB0aGUgc2xlZXBpbmcgcHJvY2VzcyBpbiBA
cCB0bw0KICoJdGhlIGZvcm1hdCB0aGF0IEdEQiBleHBlY3RzLg0KICoJVGhpcyBmdW5jdGlvbiBp
cyBjYWxsZWQgd2hlbiBrZ2RiIGRvZXMgbm90IGhhdmUgYWNjZXNzIHRvIHRoZQ0KICoJJnN0cnVj
dCBwdF9yZWdzIGFuZCB0aGVyZWZvcmUgaXQgc2hvdWxkIGZpbGwgdGhlIGdkYiByZWdpc3RlcnMN
CiAqCUBnZGJfcmVncyB3aXRoIHdoYXQgaGFzCWJlZW4gc2F2ZWQgaW4gJnN0cnVjdCB0aHJlYWRf
c3RydWN0DQogKgl0aHJlYWQgZmllbGQgZHVyaW5nIHN3aXRjaF90by4NCiAqLw0KZXh0ZXJuIHZv
aWQgc2xlZXBpbmdfdGhyZWFkX3RvX2dkYl9yZWdzKHVuc2lnbmVkIGxvbmcgKmdkYl9yZWdzLA0K
CQkJCQlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnApOw0KDQovKioNCiAqCWdkYl9yZWdzX3RvX3JlZ3Mg
LSBDb252ZXJ0IEdEQiByZWdzIHRvIHB0cmFjZSByZWdzLg0KICoJQGdkYl9yZWdzOiBBIHBvaW50
ZXIgdG8gaG9sZCB0aGUgcmVnaXN0ZXJzIHdlJ3ZlIHJlY2lldmVkIGZyb20gR0RCLg0KICoJQHJl
Z3M6IEEgcG9pbnRlciB0byBhICZzdHJ1Y3QgcHRfcmVncyB0byBob2xkIHRoZXNlIHZhbHVlcyBp
bi4NCiAqDQogKglDb252ZXJ0IHRoZSBHREIgcmVncyBpbiBAZ2RiX3JlZ3MgaW50byB0aGUgcHRf
cmVncywgYW5kIHN0b3JlIHRoZW0NCiAqCWluIEByZWdzLg0KICovDQpleHRlcm4gdm9pZCBnZGJf
cmVnc190b19yZWdzKHVuc2lnbmVkIGxvbmcgKmdkYl9yZWdzLCBzdHJ1Y3QgcHRfcmVncyAqcmVn
cyk7DQoNCi8qKg0KICoJa2dkYl9hcmNoX2hhbmRsZV9leGNlcHRpb24gLSBIYW5kbGUgYXJjaGl0
ZWN0dXJlIHNwZWNpZmljIEdEQiBwYWNrZXRzLg0KICoJQHZlY3RvcjogVGhlIGVycm9yIHZlY3Rv
ciBvZiB0aGUgZXhjZXB0aW9uIHRoYXQgaGFwcGVuZWQuDQogKglAc2lnbm86IFRoZSBzaWduYWwg
bnVtYmVyIG9mIHRoZSBleGNlcHRpb24gdGhhdCBoYXBwZW5lZC4NCiAqCUBlcnJfY29kZTogVGhl
IGVycm9yIGNvZGUgb2YgdGhlIGV4Y2VwdGlvbiB0aGF0IGhhcHBlbmVkLg0KICoJQHJlbWNvbV9p
bl9idWZmZXI6IFRoZSBidWZmZXIgb2YgdGhlIHBhY2tldCB3ZSBoYXZlIHJlYWQuDQogKglAcmVt
Y29tX291dF9idWZmZXI6IFRoZSBidWZmZXIsIG9mICVCVUZNQVggdG8gd3JpdGUgYSBwYWNrZXQg
aW50by4NCiAqCUByZWdzOiBUaGUgJnN0cnVjdCBwdF9yZWdzIG9mIHRoZSBjdXJyZW50IHByb2Nl
c3MuDQogKg0KICoJVGhpcyBmdW5jdGlvbiBNVVNUIGhhbmRsZSB0aGUgJ2MnIGFuZCAncycgY29t
bWFuZCBwYWNrZXRzLA0KICoJYXMgd2VsbCBwYWNrZXRzIHRvIHNldCAvIHJlbW92ZSBhIGhhcmR3
YXJlIGJyZWFrcG9pbnQsIGlmIHVzZWQuDQogKglJZiB0aGVyZSBhcmUgYWRkaXRpb25hbCBwYWNr
ZXRzIHdoaWNoIHRoZSBoYXJkd2FyZSBuZWVkcyB0byBoYW5kbGUsDQogKgl0aGV5IGFyZSBoYW5k
bGVkIGhlcmUuICBUaGUgY29kZSBzaG91bGQgcmV0dXJuIC0xIGlmIGl0IHdhbnRzIHRvDQogKglw
cm9jZXNzIG1vcmUgcGFja2V0cywgYW5kIGEgJTAgb3IgJTEgaWYgaXQgd2FudHMgdG8gZXhpdCBm
cm9tIHRoZQ0KICoJa2dkYiBob29rLg0KICovDQpleHRlcm4gaW50IGtnZGJfYXJjaF9oYW5kbGVf
ZXhjZXB0aW9uKGludCB2ZWN0b3IsIGludCBzaWdubywgaW50IGVycl9jb2RlLA0KCQkJCSAgICAg
IGNoYXIgKnJlbWNvbV9pbl9idWZmZXIsDQoJCQkJICAgICAgY2hhciAqcmVtY29tX291dF9idWZm
ZXIsDQoJCQkJICAgICAgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpOw0KDQojaWZuZGVmIEpNUF9SRUdT
X0FMSUdOTUVOVA0KI2RlZmluZSBKTVBfUkVHU19BTElHTk1FTlQNCiNlbmRpZg0KDQpleHRlcm4g
dW5zaWduZWQgbG9uZyBrZ2RiX2ZhdWx0X2ptcF9yZWdzW107DQoNCi8qKg0KICoJa2dkYl9mYXVs
dF9zZXRqbXAgLSBTdG9yZSBzdGF0ZSBpbiBjYXNlIHdlIGZhdWx0Lg0KICoJQGN1cnJfY29udGV4
dDogQW4gYXJyYXkgdG8gc3RvcmUgc3RhdGUgaW50by4NCiAqDQogKglDZXJ0YWluIGZ1bmN0aW9u
cyBtYXkgdHJ5IGFuZCBhY2Nlc3MgbWVtb3J5LCBhbmQgaW4gZG9pbmcgc28gbWF5DQogKgljYXVz
ZSBhIGZhdWx0LiAgV2hlbiB0aGlzIGhhcHBlbnMsIHdlIHRyYXAgaXQsIHJlc3RvcmUgc3RhdGUg
dG8NCiAqCXRoaXMgY2FsbCwgYW5kIGxldCBvdXJzZWxmIGtub3cgdGhhdCBzb21ldGhpbmcgYmFk
IGhhcyBoYXBwZW5lZC4NCiAqLw0KZXh0ZXJuIGFzbWxpbmthZ2UgaW50IGtnZGJfZmF1bHRfc2V0
am1wKHVuc2lnbmVkIGxvbmcgKmN1cnJfY29udGV4dCk7DQoNCi8qKg0KICoJa2dkYl9mYXVsdF9s
b25nam1wIC0gUmVzdG9yZSBzdGF0ZSB3aGVuIHdlIGhhdmUgZmF1bHRlZC4NCiAqCUBjdXJyX2Nv
bnRleHQ6IFRoZSBwcmV2aW91c2x5IHN0b3JlZCBzdGF0ZS4NCiAqDQogKglXaGVuIHNvbWV0aGlu
ZyBiYWQgZG9lcyBoYXBwZW4sIHRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIHRvDQogKglyZXN0b3Jl
IHRoZSBrbm93biBnb29kIHN0YXRlLCBhbmQgc2V0IHRoZSByZXR1cm4gdmFsdWUgdG8gMSwgc28N
CiAqCXdlIGtub3cgc29tZXRoaW5nIGJhZCBoYXBwZW5lZC4NCiAqLw0KZXh0ZXJuIGFzbWxpbmth
Z2Ugdm9pZCBrZ2RiX2ZhdWx0X2xvbmdqbXAodW5zaWduZWQgbG9uZyAqY3Vycl9jb250ZXh0KTsN
Cg0KLyogT3B0aW9uYWwgZnVuY3Rpb25zLiAqLw0KZXh0ZXJuIGludCBrZ2RiX2FyY2hfaW5pdCh2
b2lkKTsNCmV4dGVybiB2b2lkIGtnZGJfZGlzYWJsZV9od19kZWJ1ZyhzdHJ1Y3QgcHRfcmVncyAq
cmVncyk7DQpleHRlcm4gdm9pZCBrZ2RiX3Bvc3RfbWFzdGVyX2NvZGUoc3RydWN0IHB0X3JlZ3Mg
KnJlZ3MsIGludCBlX3ZlY3RvciwNCgkJCQkgIGludCBlcnJfY29kZSk7DQpleHRlcm4gdm9pZCBr
Z2RiX3JvdW5kdXBfY3B1cyh1bnNpZ25lZCBsb25nIGZsYWdzKTsNCmV4dGVybiBpbnQga2dkYl9z
ZXRfaHdfYnJlYWsodW5zaWduZWQgbG9uZyBhZGRyKTsNCmV4dGVybiBpbnQga2dkYl9yZW1vdmVf
aHdfYnJlYWsodW5zaWduZWQgbG9uZyBhZGRyKTsNCmV4dGVybiB2b2lkIGtnZGJfcmVtb3ZlX2Fs
bF9od19icmVhayh2b2lkKTsNCmV4dGVybiB2b2lkIGtnZGJfY29ycmVjdF9od19icmVhayh2b2lk
KTsNCmV4dGVybiB2b2lkIGtnZGJfc2hhZG93aW5mbyhzdHJ1Y3QgcHRfcmVncyAqcmVncywgY2hh
ciAqYnVmZmVyLA0KCQkJICAgIHVuc2lnbmVkIHRocmVhZGlkKTsNCmV4dGVybiBzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKmtnZGJfZ2V0X3NoYWRvd190aHJlYWQoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsDQoJ
CQkJCQkgIGludCB0aHJlYWRpZCk7DQpleHRlcm4gc3RydWN0IHB0X3JlZ3MgKmtnZGJfc2hhZG93
X3JlZ3Moc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIGludCB0aHJlYWRpZCk7DQoNCi8qKg0KICogc3Ry
dWN0IGtnZGJfYXJjaCAtIERlc3JpYmUgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHZhbHVlcy4NCiAq
IEBnZGJfYnB0X2luc3RyOiBUaGUgaW5zdHJ1Y3Rpb24gdG8gdHJpZ2dlciBhIGJyZWFrcG9pbnQu
DQogKiBAZmxhZ3M6IEZsYWdzIGZvciB0aGUgYnJlYWtwb2ludCwgY3VycmVudGx5IGp1c3QgJUtH
REJfSFdfQlJFQUtQT0lOVC4NCiAqIEBzaGFkb3d0aDogQSB2YWx1ZSBvZiAlMSBpbmRpY2F0ZXMg
d2Ugc2hhZG93IGluZm9ybWF0aW9uIG9uIHByb2Nlc3Nlcy4NCiAqIEBzZXRfYnJlYWtwb2ludDog
QWxsb3cgYW4gYXJjaGl0ZWN0dXJlIHRvIHNwZWNpZnkgaG93IHRvIHNldCBhIHNvZnR3YXJlDQog
KiBicmVha3BvaW50Lg0KICogQHJlbW92ZV9icmVha3BvaW50OiBBbGxvdyBhbiBhcmNoaXRlY3R1
cmUgdG8gc3BlY2lmeSBob3cgdG8gcmVtb3ZlIGENCiAqIHNvZnR3YXJlIGJyZWFrcG9pbnQuDQog
KiBAc2V0X2h3X2JyZWFrcG9pbnQ6IEFsbG93IGFuIGFyY2hpdGVjdHVyZSB0byBzcGVjaWZ5IGhv
dyB0byBzZXQgYSBoYXJkd2FyZQ0KICogYnJlYWtwb2ludC4NCiAqIEByZW1vdmVfaHdfYnJlYWtw
b2ludDogQWxsb3cgYW4gYXJjaGl0ZWN0dXJlIHRvIHNwZWNpZnkgaG93IHRvIHJlbW92ZSBhDQog
KiBoYXJkd2FyZSBicmVha3BvaW50Lg0KICoNCiAqIFRoZSBAc2hhZG93dGggZmxhZyBpcyBhbiBv
cHRpb24gdG8gc2hhZG93IGluZm9ybWF0aW9uIG5vdCByZXRyaWV2YWJsZSBieQ0KICogZ2RiIG90
aGVyd2lzZS4gIFRoaXMgaXMgZGVwcmVjYXRlZCBpbiBmYXZvciBvZiBhIGJpbnV0aWxzIHdoaWNo
IHN1cHBvcnRzDQogKiBDRkkgbWFjcm9zLg0KICovDQpzdHJ1Y3Qga2dkYl9hcmNoIHsNCgl1bnNp
Z25lZCBjaGFyIGdkYl9icHRfaW5zdHJbQlJFQUtfSU5TVFJfU0laRV07DQoJdW5zaWduZWQgbG9u
ZyBmbGFnczsNCgl1bnNpZ25lZCBzaGFkb3d0aDsNCglpbnQgKCpzZXRfYnJlYWtwb2ludCkgKHVu
c2lnbmVkIGxvbmcsIGNoYXIgKik7DQoJaW50ICgqcmVtb3ZlX2JyZWFrcG9pbnQpKHVuc2lnbmVk
IGxvbmcsIGNoYXIgKik7DQoJaW50ICgqc2V0X2h3X2JyZWFrcG9pbnQpKHVuc2lnbmVkIGxvbmcs
IGludCwgZW51bSBrZ2RiX2JwdHlwZSk7DQoJaW50ICgqcmVtb3ZlX2h3X2JyZWFrcG9pbnQpKHVu
c2lnbmVkIGxvbmcsIGludCwgZW51bSBrZ2RiX2JwdHlwZSk7DQp9Ow0KDQovKiBUaHJlYWQgcmVm
ZXJlbmNlICovDQp0eXBlZGVmIHVuc2lnbmVkIGNoYXIgdGhyZWFkcmVmWzhdOw0KDQovKioNCiAq
IHN0cnVjdCBrZ2RiX2lvIC0gRGVzcmliZSB0aGUgaW50ZXJmYWNlIGZvciBhbiBJL08gZHJpdmVy
IHRvIHRhbGsgd2l0aCBLR0RCLg0KICogQHJlYWRfY2hhcjogUG9pbnRlciB0byBhIGZ1bmN0aW9u
IHRoYXQgd2lsbCByZXR1cm4gb25lIGNoYXIuDQogKiBAd3JpdGVfY2hhcjogUG9pbnRlciB0byBh
IGZ1bmN0aW9uIHRoYXQgd2lsbCB3cml0ZSBvbmUgY2hhci4NCiAqIEBmbHVzaDogUG9pbnRlciB0
byBhIGZ1bmN0aW9uIHRoYXQgd2lsbCBmbHVzaCBhbnkgcGVuZGluZyB3cml0ZXMuDQogKiBAaW5p
dDogUG9pbnRlciB0byBhIGZ1bmN0aW9uIHRoYXQgd2lsbCBpbml0aWFsaXplIHRoZSBkZXZpY2Uu
DQogKiBAbGF0ZV9pbml0OiBQb2ludGVyIHRvIGEgZnVuY3Rpb24gdGhhdCB3aWxsIGRvIGFueSBz
ZXR1cCB0aGF0IGhhcw0KICogb3RoZXIgZGVwZW5kZW5jaWVzLg0KICogQHByZV9leGNlcHRpb246
IFBvaW50ZXIgdG8gYSBmdW5jdGlvbiB0aGF0IHdpbGwgZG8gYW55IHByZXAgd29yayBmb3INCiAq
IHRoZSBJL08gZHJpdmVyLg0KICogQHBvc3RfZXhjZXB0aW9uOiBQb2ludGVyIHRvIGEgZnVuY3Rp
b24gdGhhdCB3aWxsIGRvIGFueSBjbGVhbnVwIHdvcmsNCiAqIGZvciB0aGUgSS9PIGRyaXZlci4N
CiAqDQogKiBUaGUgQGluaXQgYW5kIEBsYXRlX2luaXQgZnVuY3Rpb24gcG9pbnRlcnMgYWxsb3cg
Zm9yIGFuIEkvTyBkcml2ZXINCiAqIHN1Y2ggYXMgYSBzZXJpYWwgZHJpdmVyIHRvIGZ1bGx5IGlu
aXRpYWxpemUgdGhlIHBvcnQgd2l0aCBAaW5pdCBhbmQNCiAqIGJlIGNhbGxlZCB2ZXJ5IGVhcmx5
LCB5ZXQgc2FmZWx5IGNhbGwgcmVxdWVzdF9pcnEoKSBsYXRlciBpbiB0aGUgYm9vdA0KICogc2Vx
dWVuY2UuDQogKg0KICogQGluaXQgaXMgYWxsb3dlZCB0byByZXR1cm4gYSBub24tMCByZXR1cm4g
dmFsdWUgdG8gaW5kaWNhdGUgZmFpbHVyZS4NCiAqIElmIHRoaXMgaXMgY2FsbGVkIGVhcmx5IG9u
LCB0aGVuIEtHREIgd2lsbCB0cnkgYWdhaW4gd2hlbiBpdCB3b3VsZCBjYWxsDQogKiBAbGF0ZV9p
bml0LiAgSWYgaXQgaGFzIGZhaWxlZCBsYXRlciBpbiBib290IGFzIHdlbGwsIHRoZSB1c2VyIHdp
bGwgYmUNCiAqIG5vdGlmaWVkLg0KICovDQpzdHJ1Y3Qga2dkYl9pbyB7DQoJaW50ICgqcmVhZF9j
aGFyKSAodm9pZCk7DQoJdm9pZCAoKndyaXRlX2NoYXIpICh1OCk7DQoJdm9pZCAoKmZsdXNoKSAo
dm9pZCk7DQoJaW50ICgqaW5pdCkgKHZvaWQpOw0KCXZvaWQgKCpsYXRlX2luaXQpICh2b2lkKTsN
Cgl2b2lkICgqcHJlX2V4Y2VwdGlvbikgKHZvaWQpOw0KCXZvaWQgKCpwb3N0X2V4Y2VwdGlvbikg
KHZvaWQpOw0KfTsNCg0KZXh0ZXJuIHN0cnVjdCBrZ2RiX2lvIGtnZGJfaW9fb3BzOw0KZXh0ZXJu
IHN0cnVjdCBrZ2RiX2FyY2ggYXJjaF9rZ2RiX29wczsNCmV4dGVybiBpbnQga2dkYl9pbml0aWFs
aXplZDsNCg0KZXh0ZXJuIGludCBrZ2RiX3JlZ2lzdGVyX2lvX21vZHVsZShzdHJ1Y3Qga2dkYl9p
byAqbG9jYWxfa2dkYl9pb19vcHMpOw0KZXh0ZXJuIHZvaWQga2dkYl91bnJlZ2lzdGVyX2lvX21v
ZHVsZShzdHJ1Y3Qga2dkYl9pbyAqbG9jYWxfa2dkYl9pb19vcHMpOw0KDQpleHRlcm4gdm9pZCBr
Z2RiODI1MF9hZGRfcG9ydChpbnQgaSwgc3RydWN0IHVhcnRfcG9ydCAqc2VyaWFsX3JlcSk7DQpl
eHRlcm4gdm9pZCBrZ2RiODI1MF9hZGRfcGxhdGZvcm1fcG9ydChpbnQgaSwgc3RydWN0IHBsYXRf
c2VyaWFsODI1MF9wb3J0ICpzZXJpYWxfcmVxKTsNCmV4dGVybiBpbnQga2dkYjgyNTBfZ2V0X3R0
eVModm9pZCk7DQoNCmV4dGVybiBpbnQga2dkYl9oZXgybG9uZyhjaGFyICoqcHRyLCBsb25nICps
b25nX3ZhbCk7DQpleHRlcm4gY2hhciAqa2dkYl9tZW0yaGV4KGNoYXIgKm1lbSwgY2hhciAqYnVm
LCBpbnQgY291bnQpOw0KZXh0ZXJuIGNoYXIgKmtnZGJfaGV4Mm1lbShjaGFyICpidWYsIGNoYXIg
Km1lbSwgaW50IGNvdW50KTsNCmV4dGVybiBpbnQga2dkYl9nZXRfbWVtKGNoYXIgKmFkZHIsIHVu
c2lnbmVkIGNoYXIgKmJ1ZiwgaW50IGNvdW50KTsNCmV4dGVybiBpbnQga2dkYl9zZXRfbWVtKGNo
YXIgKmFkZHIsIHVuc2lnbmVkIGNoYXIgKmJ1ZiwgaW50IGNvdW50KTsNCmV4dGVybiBpbnQga2dk
Yl9oYW5kbGVfZXhjZXB0aW9uKGludCBleF92ZWN0b3IsIGludCBzaWdubywgaW50IGVycl9jb2Rl
LA0KCQkJCXN0cnVjdCBwdF9yZWdzICpyZWdzKTsNCmV4dGVybiB2b2lkIGtnZGJfbm1paG9vayhp
bnQgY3B1LCB2b2lkICpyZWdzKTsNCmV4dGVybiBpbnQgZGVidWdnZXJfc3RlcDsNCmV4dGVybiBh
dG9taWNfdCBkZWJ1Z2dlcl9hY3RpdmU7DQojZWxzZQ0KLyogU3R1YnMgZm9yIHdoZW4gS0dEQiBp
cyBub3Qgc2V0LiAqLw0Kc3RhdGljIGNvbnN0IGF0b21pY190IGRlYnVnZ2VyX2FjdGl2ZSA9IEFU
T01JQ19JTklUKDApOw0KI2VuZGlmCQkJCS8qIENPTkZJR19LR0RCICovDQojZW5kaWYJCQkJLyog
X0tHREJfSF8gKi8NCiNlbmRpZgkJCQkvKiBfX0tFUk5FTF9fICovDQo=


--=-kZrm55j35RwuwrrkWzYs
Content-Disposition: attachment; filename=sock.h.frag
Content-Type: text/plain; name=sock.h.frag; charset=ISO-8859-1
Content-Transfer-Encoding: base64

IyBpZmRlZiBTQV9UQ1BfREVCVUcNCi8qDQogKiAgQSBzaW1pbGFyIHNvY2tldCBkZWJ1ZyBtYWNy
byBleGlzdCBpcyBuZXQvY29yZS9za2J1ZmYuaA0KICovDQpleHRlcm4gdW5zaWduZWQgY2hhciBz
YV9kZWJ1Z19nbG9iYWxfZmxhZzsNCg0KI2lmIDANCiMgICBkZWZpbmUgU0FfREVCVUcobXNnLi4u
KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgIGRvIHsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAgaWYgKHNhX2RlYnVnX2dsb2Jh
bF9mbGFnKSB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgIHByaW50ayhLRVJOX0RF
QlVHICIlczogIiwgX19mdW5jX18pOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgICAgICAgICAgcHJpbnRrKG1zZyk7ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcDQogICAgICAgICAgICAgICAgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCiAgICAgICAgfSB3aGlsZSAoMCkNCiMgIGVuZGlmIA0KDQojICBkZWZpbmUgU09DS19E
RUJVRyhzaywgbXNnLi4uKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgZG8geyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgIGlmIChzYV9k
ZWJ1Z19nbG9iYWxfZmxhZyAmJiAoc2spICE9IE5VTEwpIHsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAgICAgICAgICBpZiAo
KHNrKS0+c29ja2V0X3R5cGUgfHwgKHNrKS0+dnByb3h5X2lkIHx8IChzb2NrX2ZsYWcoKHNrKSwg
U09DS19EQkcpICkpIHsgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aWYgKGZ1bmN0aW9uX2VudHJ5KG1zZykpIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cHJpbnRrKEtFUk5fREVCVUcgIiVzIiwgX19mdW5jX18pOyAgICAvKiBGdW5jdGlvbiBFbnRyeSAq
LyAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByaW50ayhL
RVJOX0RFQlVHICIlczogIiwgX19mdW5jX18pOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByaW50ayhtc2cpOyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwN
CiAgICAgICAgICAgICAgICAgICAgICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAg
ICAgICAgICAgICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAg
IH0gd2hpbGUgKDApDQoNCiMgIGRlZmluZSBTT0NLX0VSUihzaywgbXNnLi4uKSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXA0KICAgICAgICBkbyB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcDQogICAgICAgICAgICAgICAgaWYgKHNhX2RlYnVnX2dsb2JhbF9mbGFnICYmIChzaykg
IT0gTlVMTCkgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwNCiAgICAgICAgICAgICAgICAgICAgICAgIGlmICgoc2spLT5zb2NrZXRfdHlwZSB8fCAoc2sp
LT52cHJveHlfaWQgfHwgKHNvY2tfZmxhZygoc2spLCBTT0NLX0RCRykgKSkgeyAgICAgICAgXA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcmludGsoS0VSTl9FUlIgIiVzOiAiLCBf
X2Z1bmNfXyk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByaW50ayhtc2cpOyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAg
ICAgICAgICAgICAgICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAg
ICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgIH0gd2hpbGUg
KDApDQoNCiMgIGRlZmluZSBUQ1BfU09DS19ERUJVRyh0cCwgbXNnLi4uKSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XA0KICAgICAgICBkbyB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQog
ICAgICAgICAgICAgICAgc3RydWN0IHNvY2sgKnNrID0gJnRwLT5pbmV0LnNrOyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAg
ICAgICAgIGlmIChzYV9kZWJ1Z19nbG9iYWxfZmxhZyAmJiAoc2spICE9IE5VTEwpIHsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAg
ICAgICAgICAgICBpZiAoKHNrKS0+c29ja2V0X3R5cGUgfHwgKHNrKS0+dnByb3h5X2lkIHx8IChz
b2NrX2ZsYWcoKHNrKSwgU09DS19EQkcpICkpIHsgICAgICAgIFwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKGZ1bmN0aW9uX2VudHJ5KG1zZykpIHsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHByaW50ayhLRVJOX0RFQlVHICIlcyIsIF9fZnVuY19fKTsgICAgLyog
RnVuY3Rpb24gRW50cnkgKi8gICAgICAgICAgICBcDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIH0gZWxzZSB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHByaW50ayhLRVJOX0RFQlVHICIlczogIiwgX19mdW5jX18pOyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByaW50
ayhtc2cpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgIH0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXA0KICAgICAgICAgICAgICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcDQogICAgICAgIH0gd2hpbGUgKDApDQoNCiMgIGRlZmluZSBUV19TT0NLX0RFQlVHKHR3
LCBtc2cuLi4pICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICBkbyB7ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAgaWYgKHNhX2RlYnVnX2dsb2Jh
bF9mbGFnICYmICh0dykgIT0gTlVMTCkgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgIGlmICgodHcpLT5zb2Nr
ZXRfdHlwZSB8fCAodHcpLT52cHJveHlfaWQpIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoZnVuY3Rp
b25fZW50cnkobXNnKSkgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcmludGsoS0VS
Tl9ERUJVRyAiJXMiLCBfX2Z1bmNfXyk7ICAvKiBGdW5jdGlvbiBFbnRyeSAqLyAgICAgICAgICAg
ICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJpbnRrKEtFUk5fREVCVUcg
IiVzOiAiLCBfX2Z1bmNfXyk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJpbnRrKG1zZyk7ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAg
ICAgICAgICAgICAgICAgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAg
ICAgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgfSB3aGlsZSAo
MCkNCg0KIyBlbHNlIC8qICFTQV9UQ1BfREVCVUcgKi8NCg0KIyAgZGVmaW5lIFNPQ0tfREVCVUco
c2ssIG1zZy4uLikgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgIGRvIHsgaWYgKChzaykgJiYg
c29ja19mbGFnKChzayksIFNPQ0tfREJHKSkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgIHByaW50
ayhLRVJOX0RFQlVHIG1zZyk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICB9IHdoaWxlICgwKQ0KDQojICBkZWZpbmUg
U09DS19FUlIoc2ssIG1zZy4uLikgCQlkbyB7IH0gd2hpbGUgKDApDQovLyAjICBkZWZpbmUgU0Ff
REVCVUcodHAsIG1zZy4uLikgCWRvIHsgfSB3aGlsZSAoMCkNCiMgIGRlZmluZSBUQ1BfU09DS19E
RUJVRyh0cCwgbXNnLi4uKSAJZG8geyB9IHdoaWxlICgwKQ0KIyAgZGVmaW5lIFRXX1NPQ0tfREVC
VUcodHcsIG1zZy4uLikgCWRvIHsgfSB3aGlsZSAoMCkNCiMgZW5kaWYgLyogU0FfVENQX0RFQlVH
ICovDQoNCiNlbHNlIC8qICFTT0NLX0RFQlVHR0lORyAqLw0KDQovLyAjIGRlZmluZSBTQV9ERUJV
RyhzaywgbXNnLi4uKSAJZG8geyB9IHdoaWxlICgwKQ0KIyBkZWZpbmUgU09DS19ERUJVRyhzaywg
bXNnLi4uKSAJZG8geyB9IHdoaWxlICgwKQ0KIyBkZWZpbmUgU09DS19FUlIoc2ssIG1zZy4uLikg
CQlkbyB7IH0gd2hpbGUgKDApDQojIGRlZmluZSBUQ1BfU09DS19ERUJVRyh0cCwgbXNnLi4uKSAJ
ZG8geyB9IHdoaWxlICgwKQ0KIyBkZWZpbmUgVFdfU09DS19ERUJVRyh0dywgbXNnLi4uKSAJZG8g
eyB9IHdoaWxlICgwKQ0KI2VuZGlmIC8qIFNPQ0tfREVCVUdHSU5HICovDQo=


--=-kZrm55j35RwuwrrkWzYs
Content-Disposition: attachment; filename=skbuff.h.frag
Content-Type: text/plain; name=skbuff.h.frag; charset=ISO-8859-1
Content-Transfer-Encoding: base64

I2lmZGVmIENPTkZJR19WUFJPWFkNCiNpbmNsdWRlIDxuZXQvdnByb3h5Lmg+DQojIGlmIGRlZmlu
ZWQoU0FfVENQX0RFQlVHKSAmJiAhZGVmaW5lZChDT05GSUdfQVRNKQ0KZXh0ZXJuIHVuc2lnbmVk
IGNoYXIgc2FfZGVidWdfZ2xvYmFsX2ZsYWc7DQovKg0KICogQSBzaW1pbGFyIHNvY2tldCBkZWJ1
ZyBtYWNybyBleGlzdCBpcyBuZXQvc29jay5oDQogKiBTS0JfREVCVUcoKSB1bmZvcnR1bmF0bHkg
aXMgYWxzbyBkZWZpbmVkIGJ5IHNvbWUNCiAqIENPTkZJR19BVE0gY29kZTsgbWlnaHQgc3dpdGNo
IHRvIFNBX1NLQl9ERUJVRygpLg0KICovDQojICBkZWZpbmUgU0tCX0RFQlVHKHNrYiwgbXNnLi4u
KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCiAgICAgICAgZG8geyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAg
ICAgIGlmIChzYV9kZWJ1Z19nbG9iYWxfZmxhZyAmJiAoc2tiKSAhPSBOVUxMKSB7ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAgICAgICAgICBpZiAoKHNr
YiktPnZkYXRhLnZwcm94eV9mbGFncyAmIFBST1hZX1BBQ0tFVCApIHsgICAgICAgICAgICAgICAg
ICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGZ1bmN0aW9uX2VudHJ5
KG1zZykpIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByaW50ayhLRVJOX0RFQlVHICIlcyIsIF9fZnVu
Y19fKTsgICAgLyogRW50cnkgKi8gICBcDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IH0gZWxzZSB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcmludGsoS0VS
Tl9ERUJVRyAiJXM6ICIsIF9fZnVuY19fKTsgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHByaW50ayhtc2cpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAg
ICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgIH0gd2hpbGUgKDApDQojIGVsc2UgLyog
IVNBX1RDUF9ERUJVRyAqLw0KIyBlbHNlIC8qICFDT05GSUdfVlBST1hZICovDQojIGRlZmluZSBT
S0JfREVCVUcoc2ssIG1zZy4uLikgZG8geyB9IHdoaWxlICgwKQ0KI2VuZGlmIC8qIENPTkZJR19W
UFJPWFkgKi8NCg==


--=-kZrm55j35RwuwrrkWzYs
Content-Disposition: attachment; filename=trace_example
Content-Type: text/plain; name=trace_example; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ3MTFdICAgICAgICAg
ICAgICAgICAgICB2cHJveHlfaXBfbG9jYWxfZGVsaXZlcl9maW5pc2goc2tiOmRmYmYzYzgwKQ0K
SnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ3MTRdICAgICAgICAg
ICAgICAgICAgICBpcF9sb2NhbF9kZWxpdmVyX2ZpbmlzaChza2I6ZGZiZjNjODApDQpKdW4gIDEg
MTk6MTc6NTkgbG9jYWxob3N0IGtlcm5lbDogWyAzMTgwLjAzNDcxOF0gICAgICAgICAgICAgICAg
ICAgICB0Y3BfdjRfcmN2KHNrYjpkZmJmM2M4MCkNCkp1biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qg
a2VybmVsOiBbIDMxODAuMDM0NzIxXSAgICAgICAgICAgICAgICAgICAgICAgc2FfdGNwX3Y0X3Jj
dihza2I6ZGZiZjNjODApIHsNCkp1biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMx
ODAuMDM0NzI2XSAgICAgICAgICAgICAgICAgICAgICAgc2FfdGNwX3Y0X3JjdjogU0FfVENQX0lO
Q19TVEFUUyhTQV9UQ1BfU1RBVFNfUGt0UmVjZWl2ZWQ6MCkNCkp1biAgMSAxOToxNzo1OSBsb2Nh
bGhvc3Qga2VybmVsOiBbIDMxODAuMDM0NzMxXSAgICAgICAgICAgICAgICAgICAgICAgIF9fbmV3
X3Zwcm94eV90Y3BfdjRfbG9va3VwX2VzdGFibGlzaGVkOiBGYWlsZWQgdG8gZmluZCBlc3RhYmxp
c2hlZCBzb2NrZXQ7IHJldHVybihOVUxMKTsNCkp1biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2Vy
bmVsOiBbIDMxODAuMDM0NzM5XSAgICAgICAgICAgICAgICAgICAgICAgIHNhX3RjcF92NF9yY3Y6
IHNrYjpkZmJmM2M4MC0+e2Rldi0+bmFtZTondTAnLCB2ZGF0YS57b3V0ZGV2LT5uYW1lOid1MCcs
IGluZGV2LT5uYW1lOidwMCd9IH0NCkp1biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2VybmVsOiBb
IDMxODAuMDM0NzQxXSAgICAgICAgICAgICAgICAgICAgICAgIC4uLiAgIFRDUCBQYWNrZXQgd2l0
aCBzcmM6KDE5Mi4xNjguMTM2LjEwMzozMjk4OSkgZGVzdDooMTkyLjE2OC4xMzUuMTAyOjUwMDEp
DQpKdW4gIDEgMTk6MTc6NTkgbG9jYWxob3N0IGtlcm5lbDogWyAzMTgwLjAzNDc0M10gICAgICAg
ICAgICAgICAgICAgICAgICAuLi4gICBUQ1AgRkxBR1M6JyAgICBTICcgU2VxOjIxNDIzMzk0OSwg
RW5kX3NlcToyMTQyMzM5NTAsIEFja19zZXE6MCwgV2luZG93OjU4NDANCkp1biAgMSAxOToxNzo1
OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMxODAuMDM0NzQ1XSAgICAgICAgICAgICAgICAgICAgICAg
IC4uLiAgIHNrYi0+aXBfc3VtbWVkOjIsIHNrYi0+Y3N1bToweDAsIHRoLT5jaGVjazoweDZlZjAN
Ckp1biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMxODAuMDM0NzQ5XSAgICAgICAg
ICAgICAgICAgICAgICAgc2FfdGNwX3Y0X3JjdjogJ0NsaWVudCcgcGFja2V0OyBzazowMDAwMDAw
MCA9IF9fbmV3X3Zwcm94eV90Y3BfdjRfbG9va3VwX2VzdGFibGlzaGVkKCk7DQpKdW4gIDEgMTk6
MTc6NTkgbG9jYWxob3N0IGtlcm5lbDogWyAzMTgwLjAzNDc1M10gICAgICAgICAgICAgICAgICAg
ICAgIHNhX3RjcF92NF9yY3Y6IHRtcF9jaGVja3N1bV9yZWNlaXZlZDoyLCBza2I6ZGZiZjNjODAt
PntpcF9zdW1tZWQ6MiwgY3N1bToweDB9IHRoLT5jaGVjayAweDZlZjANCkp1biAgMSAxOToxNzo1
OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMxODAuMDM0NzU2XSAgICAgICAgICAgICAgICAgICAgICAg
c2FfdGNwX3Y0X3JjdjogTGlzdGVuaW5nIHNvY2tldCAweGRlMzE5MDgwIHN0YXRlIDEwOkxpc3Rl
bg0KSnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ3NjFdICAgICAg
ICAgICAgICAgICAgICAgICBzYV90Y3BfdjRfcmN2OiBUYWtpbmcgbG9jayBvbiBjbGllbnQvbGlz
dGVuIHNrOjB4ZGUzMTkwODANCkp1biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMx
ODAuMDM0NzY0XSAgICAgICAgICAgICAgICAgICAgICAgc2FfdGNwX3Y0X3JjdjogYmhfbG9ja19z
b2NrKHNrOjB4ZGUzMTkwODApOw0KSnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsg
MzE4MC4wMzQ3NjddICAgICAgICAgICAgICAgICAgICAgICBzYV90Y3BfdjRfcmN2OiBTQV9UQ1Bf
SU5DX1NUQVRTKFNBX1RDUF9TVEFUU19Qa3RSZWNlaXZlZEZvckxpc3RlbmluZ1NvY2tldDowKQ0K
SnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ3NzFdICAgICAgICAg
ICAgICAgICAgICAgICBzYV90Y3BfdjRfcmN2OiBDbGllbnQvbGlzdGVuIHNvY2sgcGt0OiBHb3Qg
dGhlIGxvY2tzDQpKdW4gIDEgMTk6MTc6NTkgbG9jYWxob3N0IGtlcm5lbDogWyAzMTgwLjAzNDc3
NV0gICAgICAgICAgICAgICAgICAgICAgICBzYV90Y3BfdjRfZG9fcmN2KHNrOjB4ZGUzMTkwODAs
IHNrYjoweGRmYmYzYzgwKSBzay0+c2tfc3RhdGU6MTA6J0xpc3RlbicNCkp1biAgMSAxOToxNzo1
OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMxODAuMDM0Nzc5XSAgICAgICAgICAgICAgICAgICAgICAg
ICBzYV9jbGllbnRfdGNwX3Y0X2huZF9yZXEoc2s6ZGUzMTkwODAsIHNrYjpkZmJmM2M4MCkNCkp1
biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMxODAuMDM0Nzg0XSAgICAgICAgICAg
ICAgICAgICAgICAgICAgdnByb3h5X3RjcF92NF9zZWFyY2hfcmVxKHRwOjB4ZGUzMTkwODAsIHBy
ZXZwOmMwNjEzYTQwLCBycG9ydDo1NjcwNCwgbHBvcnQ6MzUwOTEsIHJhZGRyOjY3ODhhOGMwLCBs
YWRkcjo2Njg3YThjMCkgew0KSnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4
MC4wMzQ3OTBdICAgICAgICAgICAgICAgICAgICAgICAgICB2cHJveHlfdGNwX3Y0X3NlYXJjaF9y
ZXE6IHJldHVybihyZXE6MDAwMDAwMDApOyANCkp1biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2Vy
bmVsOiBbIDMxODAuMDM0NzkyXSAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KSnVuICAxIDE5
OjE3OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ3OTRdICAgICAgICAgICAgICAgICAg
ICAgICAgICBfX25ld192cHJveHlfdGNwX3Y0X2xvb2t1cF9lc3RhYmxpc2hlZDogRmFpbGVkIHRv
IGZpbmQgZXN0YWJsaXNoZWQgc29ja2V0OyByZXR1cm4oTlVMTCk7DQpKdW4gIDEgMTk6MTc6NTkg
bG9jYWxob3N0IGtlcm5lbDogWyAzMTgwLjAzNDc5OV0gICAgICAgICAgICAgICAgICAgICAgICAg
IF9fbmV3X3Zwcm94eV90Y3BfdjRfbG9va3VwX2VzdGFibGlzaGVkOiBGYWlsZWQgdG8gZmluZCBl
c3RhYmxpc2hlZCBzb2NrZXQ7IHJldHVybihOVUxMKTsNCkp1biAgMSAxOToxNzo1OSBsb2NhbGhv
c3Qga2VybmVsOiBbIDMxODAuMDM0ODAyXSAgICAgICAgICAgICAgICAgICAgICAgICBzYV9jbGll
bnRfdGNwX3Y0X2huZF9yZXE6IHJldHVybihzazpkZTMxOTA4MCk7DQpKdW4gIDEgMTk6MTc6NTkg
bG9jYWxob3N0IGtlcm5lbDogWyAzMTgwLjAzNDgwNl0gICAgICAgICAgICAgICAgICAgICAgICBz
YV90Y3BfdjRfZG9fcmN2OiBMSVNURU5JTkcgU09DS0VUOyBza19zdGF0ZToxMDonTGlzdGVuJw0K
SnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ4MDldICAgICAgICAg
ICAgICAgICAgICAgICAgIHNhX3RjcF9yY3Zfc3RhdGVfcHJvY2VzcyhzazoweGRlMzE5MDgwLCBz
a2IgMHhkZmJmM2M4MCwgdGg6MHhmN2VmZTA3NCwgbGVuOjQwKSBzay0+c3RhdGU6MTA6J0xpc3Rl
bicNCkp1biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMxODAuMDM0ODE2XSAgICAg
ICAgICAgICAgICAgICAgICAgICAgc2FfdGNwX3Y0X2Nvbm5fcmVxdWVzdChzazoweGRlMzE5MDgw
LCBza2I6MHhkZmJmM2M4MCkNCkp1biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMx
ODAuMDM0ODE5XSAgICAgICAgICAgICAgICAgICAgICAgICAgc2FfdGNwX3Y0X2Nvbm5fcmVxdWVz
dDogU0FfVENQX0lOQ19TVEFUUyhTQV9UQ1BfU1RBVFNfTmV3U3luUmVjZWl2ZWQ6MCkNCkp1biAg
MSAxOToxNzo1OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMxODAuMDM0ODI3XSAgICAgICAgICAgICAg
ICAgICAgICAgICAgc2FfdGNwX3Y0X2Nvbm5fcmVxdWVzdDogU0FfVENQX0lOQ19TVEFUUyhTQV9U
Q1BfU1RBVFNfT3BlbnJlcUNyZWF0ZWQ6MCkNCkp1biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2Vy
bmVsOiBbIDMxODAuMDM0ODMzXSAgICAgICAgICAgICAgICAgICAgICAgICAgIHNhX3NlcnZlcl9j
cmVhdGVfcGVlcl9yZXF1ZXN0KHNrOmRlMzE5MDgwLCBza2I6ZGZiZjNjODAsIHJ4X29wdHM6YzA2
MTM3ZTgsIGNsaWVudF9yZXE6ZTY2MjI4MDAsIHNlcnZlcl9yZXE6ZTY2MjI3ODApDQpKdW4gIDEg
MTk6MTc6NTkgbG9jYWxob3N0IGtlcm5lbDogWyAzMTgwLjAzNDgzOV0gICAgICAgICAgICAgICAg
ICAgICAgICAgICBzYV9zZXJ2ZXJfY3JlYXRlX3BlZXJfcmVxdWVzdDogc2VydmVyX3RjcF9yZXE6
ZTY2MjI3ODAtPnNudF9pc246MHgwID0gY2xpZW50X3RjcF9yZXE6ZTY2MjI4MDAtPnJjdl9pc246
MHhjYzRmMzVkOw0KSnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ4
NDVdICAgICAgICAgICAgICAgICAgICAgICAgICAgc2Ffc2VydmVyX3RjcF92NF9zZW5kX3N5bjog
U2VuZGluZyBvdXQgdGhlIFNZTiBwYWNrZXQgd2l0aG91dCBtb2RpZnlpbmcgQU5ZIGRhdGEuDQpK
dW4gIDEgMTk6MTc6NTkgbG9jYWxob3N0IGtlcm5lbDogWyAzMTgwLjAzNDg0OV0gICAgICAgICAg
ICAgICAgICAgICAgICAgICBzYV9zZXJ2ZXJfdGNwX3Y0X3NlbmRfc3luOiBidWZmOmRmYmYzYzgw
LT57aXBfc3VtbWVkOjAsIGNzdW06MCwgaC50aC0+Y2hlY2s6MHg2ZWYwfQ0KSnVuICAxIDE5OjE3
OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ4NTNdICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2Ffc2VydmVyX3RjcF92NF9zZW5kX3N5bjogbnRvaGwoYnVmZjpkZmJmM2M4MC0+aC50
aC0+c2VxOjB4NWRmM2M0MGMpOjB4Y2M0ZjM1ZCBbTkVXXQ0KSnVuICAxIDE5OjE3OjU5IGxvY2Fs
aG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ4NTddICAgICAgICAgICAgICAgICAgICAgICAgICAgc2Ff
c2VydmVyX3RjcF92NF9zZW5kX3N5bjogdGNwX3JlcTplNjYyMjgwMC0+e3Jjdl9pc246MHhjYzRm
MzVkLCBzbnRfaXNuOjB4MH0NCkp1biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMx
ODAuMDM0ODYwXSAgICAgICAgICAgICAgICAgICAgICAgICAgIHNhX3NlcnZlcl90Y3BfdjRfc2Vu
ZF9zeW46IHBlZXJfdGNwX3JlcTplNjYyMjc4MC0+e3Jjdl9pc246MHhjYzRmMzVkLCBzbnRfaXNu
OjB4Y2M0ZjM1ZH0NCkp1biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMxODAuMDM0
ODY1XSAgICAgICAgICAgICAgICAgICAgICAgICAgICBzYV90Y3BfZm9yd2FyZF9MNF9wYWNrZXQo
c2tiOjB4ZGZiZjNjODApIHNrYi0+e2lwOnN1bW1lZDowLCBjc3VtOjAsIGNoZWNrc3VtOjB4NmVm
MH0NCkp1biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMxODAuMDM0ODY5XSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc2FfaXBfZmFzdF9vdXRwdXQoc2tiOmRmYmYzYzgwKQ0K
SnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ4NzZdICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc2FfaXBfZmFzdF9vdXRwdXQ6IHNrYjpkZmJmM2M4MC0+e2Rl
di0+bmFtZTonPDxObyBEZXY+PicsIHZkYXRhLntvdXRkZXYtPm5hbWU6J3UwJywgaW5kZXYtPm5h
bWU6J3AwJ30gfQ0KSnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ4
NzhdICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uICAgVENQIFBhY2tldCB3aXRoIHNy
YzooMTkyLjE2OC4xMzYuMTAzOjMyOTg5KSBkZXN0OigxOTIuMTY4LjEzNS4xMDI6NTAwMSkNCkp1
biAgMSAxOToxNzo1OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMxODAuMDM0ODgwXSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC4uLiAgIFRDUCBGTEFHUzonICAgIFMgJyBTZXE6MjE0MjMzOTQ5
LCBFbmRfc2VxOjIxNDIzMzk1MCwgQWNrX3NlcTowLCBXaW5kb3c6NTg0MA0KSnVuICAxIDE5OjE3
OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ4ODJdICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLi4uICAgc2tiLT5pcF9zdW1tZWQ6MCwgc2tiLT5jc3VtOjB4MCwgdGgtPmNoZWNr
OjB4NmVmMA0KSnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ4ODZd
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2FfeG1pdF9pcF9wa3RzKHNrYjpkZmJmM2M4
MCkgc2tiLT52ZGF0YS57bDJ0eXBlOjAsIGwyYWRkbGVuOjB9LCBza2ItPmgudGgtPmNoZWNrOjB4
NmVmMA0KSnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ4OTFdICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fc2tiX3F1ZXVlX3RhaWwobGlzdDpjMjUx
NjMxNCwgbmV3c2s6ZGZiZjNjODApDQpKdW4gIDEgMTk6MTc6NTkgbG9jYWxob3N0IGtlcm5lbDog
WyAzMTgwLjAzNDg5NV0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fc2tiX2Rl
cXVldWU6IHJldHVybihyZXN1bHQ6ZGZiZjNjODApDQpKdW4gIDEgMTk6MTc6NTkgbG9jYWxob3N0
IGtlcm5lbDogWyAzMTgwLjAzNDg5OV0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNhX2lw
X2Zhc3Rfb3V0cHV0OiByZXR1cm4ocmV0OjApOw0KSnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBr
ZXJuZWw6IFsgMzE4MC4wMzQ5MDJdICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0Y3BfcmVz
ZXRfa2VlcGFsaXZlX3RpbWVyKHNrOmRlMzE5MDgwLCBsZW46MmVlKQ0KSnVuICAxIDE5OjE3OjU5
IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ5MDZdICAgICAgICAgICAgICAgICAgICAgICAg
ICBzYV90Y3BfdjRfY29ubl9yZXF1ZXN0OiByZXR1cm4oMCk7DQpKdW4gIDEgMTk6MTc6NTkgbG9j
YWxob3N0IGtlcm5lbDogWyAzMTgwLjAzNDkwOV0gICAgICAgICAgICAgICAgICAgICAgICBzYV90
Y3BfdjRfZG9fcmN2OiByZXR1cm4ocmV0OjApOw0KSnVuICAxIDE5OjE3OjU5IGxvY2FsaG9zdCBr
ZXJuZWw6IFsgMzE4MC4wMzQ5MTJdICAgICAgICAgICAgICAgICAgICAgICBzYV90Y3BfdjRfcmN2
OiBSZWxlYXNlIGNsaWVudC9saXN0ZW4gc29jayBsb2NrIHNrOjB4ZGUzMTkwODANCkp1biAgMSAx
OToxNzo1OSBsb2NhbGhvc3Qga2VybmVsOiBbIDMxODAuMDM0OTE2XSAgICAgICAgICAgICAgICAg
ICAgICAgc2FfdGNwX3Y0X3JjdjogYmhfdW5sb2NrX3NvY2soc2s6MHhkZTMxOTA4MCk7DQpKdW4g
IDEgMTk6MTc6NTkgbG9jYWxob3N0IGtlcm5lbDogWyAzMTgwLjAzNDkxOV0gICAgICAgICAgICAg
ICAgICAgICAgIHNhX3RjcF92NF9yY3Y6IHJldHVybihyZXQ6MCk7IA0KSnVuICAxIDE5OjE3OjU5
IGxvY2FsaG9zdCBrZXJuZWw6IFsgMzE4MC4wMzQ5MjFdICAgICAgICAgICAgICAgICAgICAgICB9
DQo=


--=-kZrm55j35RwuwrrkWzYs--

--=-VJkE19jisQRzOXrCDCEr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBFFGZdJICwm/rv3hoRAu0iAJ9ii5foTYQx7dLXNqvBmxzFA7rO5QCeNB85
GJ0OFN8ryItYGOu4h+OyZHw=
=WIX0
-----END PGP SIGNATURE-----

--=-VJkE19jisQRzOXrCDCEr--

