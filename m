Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289058AbSA0XiW>; Sun, 27 Jan 2002 18:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289061AbSA0XiD>; Sun, 27 Jan 2002 18:38:03 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:26386 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S289058AbSA0Xh7>;
	Sun, 27 Jan 2002 18:37:59 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "kumar M" <kumarm4@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: exporting kernel symbols 
In-Reply-To: Your message of "Sun, 27 Jan 2002 15:16:10 -0000."
             <F206dZTLOAnjLGXYB1J00005490@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 28 Jan 2002 10:37:44 +1100
Message-ID: <27549.1012174664@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2002 15:16:10 +0000, 
"kumar M" <kumarm4@hotmail.com> wrote:
>I am interested in knowing how mangling the name of symbols
>exported by the kernel to include the checksum of the information related to 
>that symbol is done, whenever MOD VERSIONS
>is used for building a module. Is there any documentation on the
>process of the checksum computation, and which portion of the linux
>sources I need to go through to understand this ?

genksyms.c in the modutils source package[1].  The make dep process
pre-processes the C sources from each directory feeding the cpp output
into genksyms.  genksyms calculates a hash for each exported symbol
based on its type, return values, parameters etc., recursively
descending parameter types as required.

The resulting hashes are written out as #defines to change foo to
foo_Rxxxxxxxx.  The defines are read back in when the real compile is
done, change references to foo into foo_Rxxxxxxxx.  In the kernel the
original symbols are used but the export list includes the suffix.  In
modules, external references include the suffix.

In theory if a module refers to a symbol and the hashes for that symbol
match then the symbol has not changed its ABI and it is safe to load
the module, even if the kernel and module are from different versions.
In practice, modversions relies far too much on human processes and is
prone to false positives.  The hashes can match when the ABI is
different because of human error[2], especially when people compile
drivers outside the kernel tree.  Kernel and modutils 2.5 will have a
completely different method for checking ABI compatibility, if kbuild
2.5 ever gets in.

[1] http://kernel.org/pub/linux/utils/kernel/modutils/v2.4
[2] http://prdownloads.sourceforge.net/kbuild/kbuild-2.5-history.tar.bz2

