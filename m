Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313934AbSDKAFB>; Wed, 10 Apr 2002 20:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313935AbSDKAFA>; Wed, 10 Apr 2002 20:05:00 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:17934 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313934AbSDKAE7>;
	Wed, 10 Apr 2002 20:04:59 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre6 standardize {aic7xxx,aicasm}/Makefile 
In-Reply-To: Your message of "Wed, 10 Apr 2002 21:52:57 +0200."
             <3CB49819.140EEC01@linux-m68k.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Apr 2002 10:04:47 +1000
Message-ID: <10197.1018483487@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002 21:52:57 +0200, 
Roman Zippel <zippel@linux-m68k.org> wrote:
>Keith Owens wrote:
>
>>     foo_files := $(srcfile foo-gen) $(srcfile foo.out_shipped)
>>     $(objfile foo_sum.d): $(srcfile foo_sum) $(foo_files)
>
>Why don't we use a script like this:
>
>set -e 
>src=$1
>dst=$2
>shift 2
>
>test -f $dst && tail -1 $dst | sed 's,/\* \(.*\) \*/,\1,' | md5sum -c &&
>touch $dst && exit 0
>echo "$@"
>"$@"
>echo "/* $(md5sum $src) */" >> $dst
>
>Then just call it with:
>	<script> <src> <dst> <build command>
>
>This is much simpler and also it also gets rid of these small checksum
>files.

There can be multiple destination files, e.g. running yacc produces a
.c and a .h file.

The generated file is not necessarily .[ch], wrapping the md5sum in
/* */ may break some generated files.  AFAIK all currently generated
files are .[ch] but I do not want to restrict future builds.

The output can change without the inputs changing.  For example, the
distributor might find a bug in the tool that generates the file,
install a new version of the tool and regenerate.  The inputs have not
changed but the output has.  To detect this, the md5sum is across all
files, including the outputs, which makes it impossible to store the
sum in one of the output files.

Unlikely I know, but I want 100% coverage on these special cases.  90%
reliability on a kernel build was acceptable when everybody was an
expert, but not now that the population of kernel builders is in the
tens of thousands.  There are far too many build problems where the
response is "make mrproper", because of the special cases that fail.

