Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267078AbTBDAxn>; Mon, 3 Feb 2003 19:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbTBDAxn>; Mon, 3 Feb 2003 19:53:43 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:19943 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267078AbTBDAxm>; Mon, 3 Feb 2003 19:53:42 -0500
Message-ID: <3E3F11B7.4010306@gmx.net>
Date: Tue, 04 Feb 2003 02:04:55 +0100
From: Thomas Heinz <thomasheinz@gmx.net>
Reply-To: Thomas Heinz <thomasheinz@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Concatenation of dynamic structs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Consider the following structs:

struct a
{
         char len;
         char c[0];
};

struct b
{
         char len;
         void *p[0];
};

Now, we have struct a *x; and we want to store n characters starting
from x->c. After the n characters we want a struct b to begin
which contains m pointers. Everything should be contained in one
contiguous memory block.

Now, several problems arise. First of all, if one wants to allocate
memory for x we cannot simply call
x = kmalloc(sizeof(*x) + n + sizeof(struct b) + m * sizeof(void *));

Instead we need something like this:
#define ALIGN(size, align) (((size) + ((align) - 1)) & (~ ((align) - 1)))
#define MAXALIGN (__alignof__(struct a) > __alignof__(struct b) ? \
                   __alignof__(struct a) : __alignof__(struct b))
x = kmalloc(ALIGN(sizeof(*x) + n, MAXALIGN) + m * sizeof(void *));


A second problem is how to define a macro (or inline function) that
returns a pointer to struct b within the concatenated struct.
Something like:
#define GETB(x) ((struct b *) ((char *) (x) + \
                   ALIGN(sizeof(*(x)) + (x)->len, MAXALIGN)))
should work.


Anyway, this is all very ugly. Is there any recommended, portable
solution for concatenating dynamic structs with different alignment
requirements?

Would it work in the general case if we define ALIGN the following way:
#define ALIGN(size) (((size) + ((__alignof__(u64)) - 1)) & \
                      (~ ((__alignof__(u64)) - 1)))

I.e. is __alignof__(u64) always the "strictest alignment requirement"
for all architectures?

Thanks for your help.
BTW, please cc your reply to my private e-mail since I'm currently
not subscribed.


Regards,

Thomas

