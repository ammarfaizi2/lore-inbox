Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311382AbSCMVp3>; Wed, 13 Mar 2002 16:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311383AbSCMVpT>; Wed, 13 Mar 2002 16:45:19 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:58775 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311382AbSCMVpK>; Wed, 13 Mar 2002 16:45:10 -0500
Message-ID: <3C8FC84B.1060704@us.ibm.com>
Date: Wed, 13 Mar 2002 13:44:43 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Anton Blanchard <anton@samba.org>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020313085217.GA11658@krispykreme> <460695164.1016001894@[10.10.2.3]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>Due to the final link and compress stage, there is a fair amount of idle
>>time at the end of the run. Its going to be hard to push that number
>>lower by adding cpus.
> 
> I think we need to fix the final phase .... anyone got any ideas
> on parallelizing that?
The final linking stage in the makefile looks like this:

vmlinux: piggy.o $(OBJECTS)
	$(LD) $(ZLINKFLAGS) -o vmlinux $(OBJECTS) piggy.o

ld has a "-r" option
        `--relocateable'
            Generate relocatable output---i.e., generate an output
            file that can in turn serve as input to `ld'.  This is
            often  called  partial  linking.  As a side effect, in
            environments that support standard Unix magic numbers,
            this  option  also sets the output file's magic number
            to `OMAGIC'.  If this  option  is  not  specified,  an
            absolute file is produced.  When linking C++ programs,
            this option will not resolve references  to  construc­
            tors; to do that, use -Ur.

If we link in chunks, we can parallelize this.
Image 26 object files: [a-z].o

ld -r -o abcd.o [abcd].o
ld -r -o efgh.o [efgh].o
...
ld -r -o abcdefgh.o {abcd,efgh,...}.o

then, instead of the old final link stage:
$(LD) $(ZLINKFLAGS) -o vmlinux {abcdefgh,...}.o piggy.o

The final link will still take a while, but we will have at least broken 
up SOME of the work.  I'm going to see if this will actually work now. 
Any comments?

-- 
Dave Hansen
haveblue@us.ibm.com

