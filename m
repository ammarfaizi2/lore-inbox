Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSEQNnP>; Fri, 17 May 2002 09:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316220AbSEQNnO>; Fri, 17 May 2002 09:43:14 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:1548 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316217AbSEQNnM>; Fri, 17 May 2002 09:43:12 -0400
Message-Id: <200205171340.g4HDe8Y22277@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Rusty Russell <rusty@rustcorp.com.au>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Date: Fri, 17 May 2002 15:42:35 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E178gok-0001Ln-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 May 2002 10:26, Rusty Russell wrote:
> >
> >    Sorry I wasn't clear: I'm saying *replace*, not add,
> >
> > I don't understand what you are proposing then.  There are some
> > instances that do want to know how many bytes did make it before
> > the -EFAULT event.
>
> Yes.  There are 52 places which care.  Most of these are unneccessary
> attempts to return eg. number of bytes written in read call before we
> hit the fault, instead of -EFAULT.
>
> The one case I found which obviously needed it was the mount options
> code, and I proposed a simple (slow) gradually_copy_from_user for this
> case:
>
> 	static inline unsigned long
> 	gradual_copy_from_user(void *to, const void *from, unsigned long n)
> 	{
> 		unsigned long i;
>
> 		for (i = 0; i < n; i++, to++, from++) {
> 			if (copy_from_user(from, to, 1) != 0)
> 				break;
> 		}
> 		return n - i;
> 	}

It looks simple to my uncomplicated mind to make
copy_{to,from}_user() return number of bytes copied.
If they != bytes requested, there was -EFAULT.

This can be easily wrapped by inline which returns only
0 on success or -EFAULT on failure.

Then use appropriate version for each case.
--
vda
