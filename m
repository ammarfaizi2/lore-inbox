Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130648AbQLEKq7>; Tue, 5 Dec 2000 05:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130695AbQLEKqt>; Tue, 5 Dec 2000 05:46:49 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:5395 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S130648AbQLEKqi>; Tue, 5 Dec 2000 05:46:38 -0500
From: "John Meikle" <linux@procom.demon.co.uk>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "Linux Kernel Mail List" <linux-kernel@vger.kernel.org>
Subject: RE: Using map_user_kiobuf()
Date: Tue, 5 Dec 2000 10:15:55 -0000
Message-ID: <NEBBIIEABDPEIPKIJFDOGEFLDGAA.linux@procom.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <20001204215334.B9238@redhat.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven,

Changing the WRITE to READ does solve the problem, thank you.

I am still confused about why the code failed the way it did.  The module
managed to write to the full 1,000,000, and the user programme could read it
and verify it was correct.  Just nothing else worked after that!

Am I the only one who finds the READ/WRITE option back to front?


Regards,

John.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Stephen C.
Tweedie
Sent: 04 December 2000 21:54
To: John Meikle
Cc: linux-kernel@vger.kernel.org; Stephen Tweedie
Subject: Re: Using map_user_kiobuf()


Hi,

On Thu, Nov 30, 2000 at 01:07:37PM -0000, John Meikle wrote:
> I have been experimenting with a module that returns data to either a user
> space programme or another module.  A memory area is passed in, and the
data
> is written to it.  Because the memory may be allocated either by a module
or
> a user programme, a kiobuf seemed a good way of representing it.  A layer
> converts user memory to a kiobuf using map_user_kiobuf().

There are a number of fixes pending for 2.4, and released for 2.2, but
nothing that would explain the sort of kernel corruption you are
reporting --- it sounds as if you are overrunning the end of the
kiobuf, but it's hard to know without seeing the real code.

> The code in the module (without validation and error checking) is:
>
> int test_kiobuf(char* buf)
> {
>     struct kiobuf *iobuf;
>     int i;
>
>     alloc_kiovec(1, &iobuf);
>     map_user_kiobuf(WRITE, iobuf, buf, TEST_SIZE);

Careful, you can't touch the buffer for a WRITE map.  The READ/WRITE
flag is from the point of view of the user, and user write() syscalls
don't touch the data in memory!  If you want to modify the user
buffer, you need to use READ instead.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
