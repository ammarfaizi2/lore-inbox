Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316463AbSEOSQr>; Wed, 15 May 2002 14:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316464AbSEOSQr>; Wed, 15 May 2002 14:16:47 -0400
Received: from mark.mielke.cc ([216.209.85.42]:58890 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S316463AbSEOSQp>;
	Wed, 15 May 2002 14:16:45 -0400
Date: Wed, 15 May 2002 14:05:43 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Malcolm Smith <msmith@operamail.com>, linux-kernel@vger.kernel.org,
        chaffee@cs.berkeley.edu
Subject: Re: [RFC] FAT extension filters
Message-ID: <20020515140542.A3621@mark.mielke.cc>
In-Reply-To: <87u1p960va.fsf@devron.myhome.or.jp> <200205151749.g4FHnkt183716@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 01:49:46PM -0400, Albert D. Cahalan wrote:
> I think the problem is in fs/fat/dir.c where
> it does:
>         for (i = 0; i < 8; i++) {
>                 /* see namei.c, msdos_format_name */
>                 if (de->name[i] == 0x05)
>                         work[i] = 0xE5;
>                 else
>                         work[i] = de->name[i];
>         }
> That should be:
>         for (i = 0; i < 8; i++) work[i] = 0xE5;
>          /* see namei.c, msdos_format_name */
>         if (*work == 0x05) *work = 0xE5;

I assume that should be:

>         for (i = 0; i < 8; i++) work[i] = de->name[i];
>          /* see namei.c, msdos_format_name */
>         if (*work == 0x05) *work = 0xE5;

The comment from msdos/namei.c reads:

  /*  0xE5 is legal as a first character, but we must substitute 0x05     */
  /*  because 0xE5 marks deleted files.  Yes, DOS really does this.       */
  /*  It seems that Microsoft hacked DOS to support non-US characters     */
  /*  after the 0xE5 character was already in use to mark deleted files.  */

A question for the long-time kernel developers who are kind enough to
spend time on a question such as this:

Should the code:

>         for (i = 0; i < 8; i++) work[i] = de->name[i];

Be written as some sort of memcpy()? I would expect the inlined
version to do two 32-bit copies, or one 64-bit copy operation for
64-bit platforms for the above piece of code. Is much of the code
written as the above? Or is effort made to try and inline it
in some better architecture-specific way?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

