Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263178AbSJOQsS>; Tue, 15 Oct 2002 12:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSJOQsS>; Tue, 15 Oct 2002 12:48:18 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:19943 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S263178AbSJOQsR> convert rfc822-to-8bit; Tue, 15 Oct 2002 12:48:17 -0400
Importance: Normal
Sensitivity: 
Subject: Re: s390x build warnings from <linux/module.h>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: arnd@bergmann-dalldorf.de, Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF83D5DB36.D1321FFF-ONC1256C53.005AFE6B@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Tue, 15 Oct 2002 18:50:12 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 15/10/2002 18:52:04
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> during 'make modules' on s390x, I see lots of warnings about 'ignoring
>> changed section attributes for __ksymtab' that I have found to be the
>> result of changeset 1.373.196.1, where Kai changed the defaults for
module
>> exports to 'no symbols exported'.
>>
>> The problem is that there is a section '__ksymtab,"a"', while s390x
>> requires it to be '__ksymtab,"aw"' because modules must be compiled with
>> '-fpic' here, unlike afaics all the other architectures.
>
>Hmmh, there's a couple of things I don't understand, though they're most
>likely there for a reason. First of all, why do you need -fpic at all?
>kernel modules are not shared, they should get properly relocated when
>insmod'ing them, so I don't see why you're doing that.

The reason for -fpic for module code lies in the compiler. To improve the
code we use the brasl and larl instructions for function calling and
addressing data. Unluckily these two instructions have a limited range
of +-4GB. For user space programs that means that a single shared object
may not be bigger than 4GB and that no non-fpic code is linked into
shared objects. With these two restrictions we are able to generate
much better code. There is one small problem though: kernel modules.
They get loaded into the vmalloc area which is located AFTER the main
memory. A machine with more than 4 GB of main memory therefore can't
load modules anymore because the calls and references to kernel structure
can't span the distance between vmalloc area and kernel image. To get
around this problem we compile kernel modules with -fpic and make the
modutils create plt stubs and got entries. Easy ?

>The next thing I do not understand is why -fpic has the effect of marking
>the section writeable, does it make .text writeable as well? And what for?

Because -fpic code likes to relocated absolute addresses.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


