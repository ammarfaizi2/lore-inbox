Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281059AbRKKOEb>; Sun, 11 Nov 2001 09:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281060AbRKKOEV>; Sun, 11 Nov 2001 09:04:21 -0500
Received: from colorfullife.com ([216.156.138.34]:34833 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S281059AbRKKOEG>;
	Sun, 11 Nov 2001 09:04:06 -0500
Message-ID: <3BEE84F4.8090103@colorfullife.com>
Date: Sun, 11 Nov 2001 15:02:28 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: "David S. Miller" <davem@redhat.com>, jakub@redhat.com, bcrl@redhat.com,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] take 2 of the tr-based current
In-Reply-To: <20011108211143.A4797@redhat.com> <20011109041327.T4087@devserv.devel.redhat.com> <3BEBEE0B.BA1FD7EE@colorfullife.com> <20011109.070312.88700201.davem@redhat.com> <3BEBF730.86CAE1CC@colorfullife.com> <20011111110107.A4064@krispykreme> <3BEE4C04.4040406@colorfullife.com> <20011111233611.A7409@krispykreme>
Content-Type: multipart/mixed;
 boundary="------------000207020000080802050008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000207020000080802050008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Anton Blanchard wrote:

 >I changed the code a bit so that get_cpu() is now inline - this
 >represents our situation better. I think it is valid for gcc to cache
 >get_cpu across a function call in the below example because it knows
 >that get_cpu does not refer to any global variables.
 >
You are right: it seems that gcc internally decides if an inline
function is const or pure.

static inline int get_TR(void)
{
     int reg;
     __asm__ (
         "rep; nop;\n\t"
         "xor %0,%0\n\t"
         : "=r" (reg));
     return ret;
}

is always optimized as if get_TR is a function with __attribute__((const)).

Ben, is it intentional that get_TR is _not_ marked as inline? Your
version produces explicit function calls with -O2, and incorrect code
with -O99 (gcc decides to inline get_TR even without an inline
directive, and then optimizes away the calls after schedule.)

It seems that Anton's version generates the best code.
I've tested the attached version with egcs-1.1.2, gcc-2.96-98 and
gcc3-3.0.1-3, with -O0, -O2 and -O99.

--
     Manfred


--------------000207020000080802050008
Content-Type: application/msword;
 name="test.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="test.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CgpzdGF0aWMgdm9pZCBzY2hlZHVsZSh2b2lkKTsKCi8vLy8v
Ly8vIGN1dCBoZXJlIC8vLy8vLy8vLy8vLy8KCmV4dGVybiBpbnQgX19nZXRfVFJfd2FzX21p
c2NvbXBpbGVkOwpzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBnZXRfVFIodm9pZCkgX19h
dHRyaWJ1dGVfXyAoKHB1cmUpKTsKc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgZ2V0X1RS
KHZvaWQpCnsKCXVuc2lnbmVkIHRyOwoJX19hc21fXygic3RyICV3MCIKCQk6ICI9ZyIgKHRy
KQoJCTogIm0iIChfX2dldF9UUl93YXNfbWlzY29tcGlsZWQpKTsKCXJldHVybiB0cjsKfQov
Ly8vLy8vLyBjdXQgaGVyZSAvLy8vLy8vLy8vLwoKaW50IG1haW4odm9pZCkKewoJaW50IGNw
dTEsIGNwdTIsIGNwdTMsIGNwdTQ7CgljcHUxID0gZ2V0X1RSKCk7CgljcHUyID0gZ2V0X1RS
KCk7CglzY2hlZHVsZSgpOwoJY3B1MyA9IGdldF9UUigpOwoJY3B1NCA9IGdldF9UUigpOwoJ
cHJpbnRmKCJ0aGUgY3B1IHZhbHVlcyB3ZXJlICVkICVkICVkICVkLlxuIiwKCQljcHUxLCBj
cHUyLCBjcHUzLCBjcHU0KTsKCXJldHVybiAwOwp9CgpzdGF0aWMgaW50IGNwdTsKc3RhdGlj
IHZvaWQgc2NoZWR1bGUodm9pZCkKewoJY3B1ID0gMjsKCXByaW50Zigic2NoZWR1bGUgY2Fs
bGVkIC5cbiIpOwp9Cg==
--------------000207020000080802050008--


