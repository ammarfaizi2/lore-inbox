Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbSAAI1h>; Tue, 1 Jan 2002 03:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284330AbSAAI11>; Tue, 1 Jan 2002 03:27:27 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:31504 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S284144AbSAAI1O>;
	Tue, 1 Jan 2002 03:27:14 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mike Touloumtzis <miket@bluemug.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Mon, 31 Dec 2001 20:03:59 -0800."
             <20011231200359.A22497@bluemug.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 Jan 2002 19:26:59 +1100
Message-ID: <3680.1009873619@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001 20:03:59 -0800, 
Mike Touloumtzis <miket@bluemug.com> wrote:
>On Fri, Dec 28, 2001 at 12:57:58PM +1100, Keith Owens wrote:
>> 
>> Unlike the broken make dep, kbuild 2.5 extracts accurate dependencies
>> by using the -MD option of cpp and post processing the cpp list.  The
>> post processing code is slow because the current design requires every
>> compile to read a complete list of all the files, giving O(n^2)
>> effects.  Mark 2 of the core code will use a shared database with
>> concurrent update so post processing is limited to looking up just the
>> required files, instead of reading the complete list every time.
>
>Why not use '$(GCC) -c -Wp,-MD,foo.d foo.c' to generate the dependencies
>as a side effect of the regular compile step?  This enables you to skip
>the initial dependency preprocessing step entirely, and could lead to a
>speedup over even the current fastdep system.  You still have to massage
>the dependencies but you can do it based on the side-effect dependency
>output of the _previous_ build, to whatever degree that output exists.

That is exactly what kbuild 2.5 does.  The slowdown occurs when
massaging the -MD dependencies from absolute names to relative path
names.  To support separate source and object trees, renaming of trees,
different names in local and NFS mode etc., the massage code needs a
list of where all the files are before it can convert the absolute
dependencies produced by gcc.  Reading and indexing that file for every
compile is _slow_.

Larry McVoy has sent me the source code to an mmapped database (from
bitkeeper).  Using a shared mmapped database should speed the process
up considerably.

