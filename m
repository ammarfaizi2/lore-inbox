Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752318AbWAFAPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbWAFAPh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752316AbWAFAPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:15:37 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:61673 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752181AbWAFAPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:15:36 -0500
Date: Fri, 6 Jan 2006 01:15:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Bligh <mbligh@mbligh.org>, Matt Mackall <mpm@selenic.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060106001519.GA15520@elte.hu>
References: <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <43BD784F.4040804@mbligh.org> <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org> <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org> <20060105233049.GA3441@elte.hu> <Pine.LNX.4.64.0601051548290.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601051548290.3169@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Also, the profiles can be misleading at times: you often get 
> instructions with zero hits, because they always schedule together 
> with another instruction. So parsing things and then matching them up 
> (correctly) with the source code in order to annotate them is probably 
> pretty nontrivial.

yeah, but schedules-together isnt a big problem in terms of branch 
predictions: unused branches really stick out with their zero counters.  
Especially if there enough profiling hits, it's usually a quick glance 
to figure out the hotpath:

c0119e1f:   582904 <sys_gettimeofday>:
c0119e1f:   582904 	57                   	push   %edi
c0119e20:   312621 	56                   	push   %esi
c0119e21:       29 	53                   	push   %ebx
c0119e22:        0 	50                   	push   %eax
c0119e23:   285471 	50                   	push   %eax
c0119e24:       15 	8b 74 24 18          	mov    0x18(%esp),%esi
c0119e28:       21 	8b 7c 24 1c          	mov    0x1c(%esp),%edi
c0119e2c:   325688 	89 f0                	mov    %esi,%eax
c0119e2e:       26 	89 fa                	mov    %edi,%edx
c0119e30:        0 	e8 86 fe ff ff       	call   c0119cbb <timeofday_API_hacks>
c0119e35:   377758 	83 f8 01             	cmp    $0x1,%eax
c0119e38:   384539 	75 3f                	jne    c0119e79 <sys_gettimeofday+0x5a>
c0119e3a:        0 	85 f6                	test   %esi,%esi
c0119e3c:        0 	74 19                	je     c0119e57 <sys_gettimeofday+0x38>
c0119e3e:        0 	89 e0                	mov    %esp,%eax
c0119e40:        0 	e8 4b c6 fe ff       	call   c0106490 <do_gettimeofday>
c0119e45:        0 	b9 08 00 00 00       	mov    $0x8,%ecx
c0119e4a:        0 	89 f0                	mov    %esi,%eax
c0119e4c:        0 	89 e2                	mov    %esp,%edx
c0119e4e:        0 	e8 3e f2 0b 00       	call   c01d9091 <copy_to_user>
c0119e53:        0 	85 c0                	test   %eax,%eax
c0119e55:        0 	75 19                	jne    c0119e70 <sys_gettimeofday+0x51>
c0119e57:        0 	85 ff                	test   %edi,%edi
c0119e59:        0 	74 1c                	je     c0119e77 <sys_gettimeofday+0x58>
c0119e5b:        0 	b9 08 00 00 00       	mov    $0x8,%ecx
c0119e60:        0 	ba 88 3e 53 c0       	mov    $0xc0533e88,%edx
c0119e65:        0 	89 f8                	mov    %edi,%eax
c0119e67:        0 	e8 25 f2 0b 00       	call   c01d9091 <copy_to_user>
c0119e6c:        0 	85 c0                	test   %eax,%eax
c0119e6e:        0 	74 07                	je     c0119e77 <sys_gettimeofday+0x58>
c0119e70:        0 	b8 f2 ff ff ff       	mov    $0xfffffff2,%eax
c0119e75:        0 	eb 02                	jmp    c0119e79 <sys_gettimeofday+0x5a>
c0119e77:        0 	31 c0                	xor    %eax,%eax
c0119e79:      308 	5e                   	pop    %esi
c0119e7a:   749654 	5f                   	pop    %edi
c0119e7b:   415831 	5b                   	pop    %ebx
c0119e7c:      744 	5e                   	pop    %esi
c0119e7d:   361201 	5f                   	pop    %edi
c0119e7e:   373195 	c3                   	ret    

here at the top you can see that the CPU is a nice 3-issue design and 
that in this workload the branch at c0119e38 is untaken and returns from 
the function afterwards. A branch instruction followed by more than 2 
zero profile-count instructions (that are not jumps) is a good sign of 
an untaken branch. This would be a pretty strong heuristics as well i 
think. We could really make the requirement be 'zero profiling hits', 
and the branch instruction would have to get 'enough' hits, to conclude 
that the branch is a candidate for likely/unlikely.

	Ingo
