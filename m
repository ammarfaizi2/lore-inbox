Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbTANSKY>; Tue, 14 Jan 2003 13:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbTANSKY>; Tue, 14 Jan 2003 13:10:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51975 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264877AbTANSKV>; Tue, 14 Jan 2003 13:10:21 -0500
Message-ID: <3E245481.5050606@transmeta.com>
Date: Tue, 14 Jan 2003 10:18:41 -0800
From: Andrew Morgan <morgan@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Don Cohen <don-linux@isis.cs3-inc.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: execve setting capabilities incorrectly ?
References: <200301141800.h0EI0WS13467@isis.cs3-inc.com>
In-Reply-To: <200301141800.h0EI0WS13467@isis.cs3-inc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

execcap doesn't work.

Long story: Linux capabilities don't really work as POSIX intended them 
to work without filesystem support. I am not working on this these days, 
although there are some mostly complete patches on kernel.org for old 
kernels.

Because of the ambiguity of what setuid() does with the behavior I 
discussed in this old email, when combined with certain setuid-0 
programs, we had to make the kernel's default policy less like POSIX and 
more like the legacy superuser model.

You used to be able to make it work as it did in the examples below by 
raising the inheritable set and lowering the cap_bound set (which is 
another hack POSIX didn't specify).

In the absence of filesystem support for capabilities, various folk have 
come up with their own ways of leveraging the capabilities to implement 
some security models. I fear that completing the capability support as 
the POSIX draft defines them will break these other approaches.

I hope that helps clarify what you are seeing.

Cheers

Andrew [who isn't subscribed to the kernel mailing list.]

Don Cohen wrote:
> Please cc me in replies.
> 
> quoting from message dated 1998/06 to this list from Andrew Morgan
>  Subject: Fwd: Re: Capabilities 
>  ...
>  [root@godzilla progs]# ./execcap cap_net_bind_service=i sleep 1000 &
>  [1] 600
>  [root@godzilla progs]# cat /proc/600/status 
>  ...
>  CapInh: 0000000000000400
>  CapPrm: 0000000000000400
>  CapEff: 0000000000000400
> 
> My corresponding output ends up with
>  CapInh: 0000000000000400
>  CapPrm: 00000000fffffeff
>  CapEff: 00000000fffffeff
> 
> I've tried in 2.4.18 and in 2.2.16, both give the same result so
> I guess it's been this way for some time.
> 
> The caps seem to be set correctly by execcap but execve resets them. 
> Is this intentional?  
> If so, how is one now supposed to get the desired effects? 
> 
> 
> What's really weird (can someone explain this?) is that things
> seem to work better under strace:
>  strace ./execcap = head <some file root has no permission to read>
> => permission denied
> whereas without the strace it reads the file.
> 

