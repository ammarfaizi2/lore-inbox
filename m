Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVDBM1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVDBM1N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 07:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVDBM1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 07:27:13 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:26116 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261416AbVDBM07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 07:26:59 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jan Hubicka <hubicka@ucw.cz>
Subject: Re: memcpy(a,b,CONST) is not inlined by gcc 3.4.1 in Linux kernel
Date: Sat, 2 Apr 2005 15:26:53 +0300
User-Agent: KMail/1.5.4
Cc: Gerold Jury <gerold.ml@inode.at>, jakub@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gcc@gcc.gnu.org
References: <200503291542.j2TFg4ER027715@earth.phy.uc.edu> <20050401214322.GA7175@atrey.karlin.mff.cuni.cz> <200504021518.49479.vda@ilport.com.ua>
In-Reply-To: <200504021518.49479.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_N+oTCBn4mNl7c9N"
Message-Id: <200504021526.53990.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_N+oTCBn4mNl7c9N
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 02 April 2005 15:18, Denis Vlasenko wrote:
> -O2 compile does inline copying, however, suboptimally.
> Pushing/popping esi/edi on the stack is not needed.
> Also "mov $1,ecx; rep; movsl" is rather silly.

I think I am wrong about push/pop. Sorry.

However, other observation is still valid. You
may wish to compile this updated t.c and see.
--
vda

--Boundary-00=_N+oTCBn4mNl7c9N
Content-Type: text/x-csrc;
  charset="koi8-r";
  name="t.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="t.c"

static inline void * __memcpy(void * to, const void * from, int n)
{
int d0, d1, d2;
__asm__ __volatile__(
	"rep ; movsl\n\t"
	"movl %4,%%ecx\n\t"
	"andl $3,%%ecx\n\t"
	"jz 1f\n\t"	/* pay 2 byte penalty for a chance to skip microcoded rep */
	"rep ; movsb\n\t"
	"1:"
	: "=&c" (d0), "=&D" (d1), "=&S" (d2)
	: "0" (n/4), "g" (n), "1" ((long) to), "2" ((long) from)
	: "memory");
return (to);
}

/*
 * This looks ugly, but the compiler can optimize it totally,
 * as the count is constant.
 */
static inline void * __constant_memcpy(void * to, const void * from, int n)
{
#if 1	/* want to do small copies with non-string ops? */
	switch (n) {
		case 0: return to;
		case 1: *(char*)to = *(char*)from; return to;
		case 2: *(short*)to = *(short*)from; return to;
		case 4: *(int*)to = *(int*)from; return to;
#if 1	/* including those doable with two moves? */
		case 3: *(short*)to = *(short*)from;
			*((char*)to+2) = *((char*)from+2); return to;
		case 5: *(int*)to = *(int*)from;
			*((char*)to+4) = *((char*)from+4); return to;
		case 6: *(int*)to = *(int*)from;
			*((short*)to+2) = *((short*)from+2); return to;
		case 8: *(int*)to = *(int*)from;
			*((int*)to+1) = *((int*)from+1); return to;
#endif
	}
#else
	if (!n) return to;
#endif
	{
		/* load esi/edi */
		int esi, edi;
		__asm__ __volatile__(
			""
			: "=&D" (edi), "=&S" (esi)
			: "0" ((long) to),"1" ((long) from)
			: "memory"
		);
	}
	if (n >= 5*4) {
		/* large block: use rep prefix */
		int ecx;
		__asm__ __volatile__(
			"rep ; movsl"
			: "=&c" (ecx)
			: "0" (n/4)
		);
	} else {
		/* small block: don't clobber ecx + smaller code */
		if (n >= 4*4) __asm__ __volatile__("movsl");
		if (n >= 3*4) __asm__ __volatile__("movsl");
		if (n >= 2*4) __asm__ __volatile__("movsl");
		if (n >= 1*4) __asm__ __volatile__("movsl");
	}
	switch (n % 4) {
		/* tail */
		case 0: return to;
		case 1: __asm__ __volatile__("movsb"); return to;
		case 2: __asm__ __volatile__("movsw"); return to;
		default: __asm__ __volatile__("movsw\n\tmovsb"); return to;
	}
}

#define memcpy(t, f, n) \
(__builtin_constant_p(n) ? \
 __constant_memcpy((t),(f),(n)) : \
 __memcpy((t),(f),(n)))


#define STRUCT1(n) struct s##n { char c[n]; } v##n, w##n; void f##n(void) { v##n = w##n; } void g##n(void) { memcpy(&v##n,&w##n,n); }
#define STRUCT(n) STRUCT1(n)

STRUCT(1)
STRUCT(2)
STRUCT(3)
STRUCT(4)
STRUCT(5)
STRUCT(6)
STRUCT(7)
STRUCT(8)
STRUCT(9)
STRUCT(10)
STRUCT(11)
STRUCT(12)
STRUCT(13)
STRUCT(14)
STRUCT(15)
STRUCT(16)
STRUCT(17)
STRUCT(18)
STRUCT(19)
STRUCT(20)

--Boundary-00=_N+oTCBn4mNl7c9N--

