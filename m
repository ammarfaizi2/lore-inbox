Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161600AbWJDQvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161600AbWJDQvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161602AbWJDQvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:51:39 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:53322 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161600AbWJDQvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:51:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=ZTD5/xIjhcgPtCpbGJxDykSuXm85fDeHKymlqnzGycpKi8uAu8Mwu12J1f9ojMkBTriJsG+0bznsrzUBJRzhvCs98jWDirtQGuvZksdG5VcMaupwCrVM4WPZRUUb/A3u+UEfF+1h+bceMY90lou99CwpHr9gyLtxoMEOU94mHnM=
Reply-To: andrew.j.wade@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Date: Wed, 4 Oct 2006 12:47:00 -0400
User-Agent: KMail/1.9.1
Cc: andrew.j.wade@gmail.com, tim.c.chen@linux.intel.com,
       herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       leonid.i.ananiev@intel.com
References: <1159916644.8035.35.camel@localhost.localdomain> <200610032324.29454.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20061003203244.9edd94b9.akpm@osdl.org>
In-Reply-To: <20061003203244.9edd94b9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041251.26166.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 October 2006 23:32, Andrew Morton wrote:

> It might help, but we still don't know what's going on (I think).
> 
> I mean, if cache misses against __warn_once were sufficiently high for it
> to affect performance, then __warn_once would be, err, in cache?

Yes, of course. I'm embarrassed.

I took a look at the generated code, and GCC is having difficulty
optimizing WARN_ON_ONCE. Here is the start of __local_bh_enable:

00000130 <__local_bh_enable>:
 130:   83 ec 10                sub    $0x10,%esp
 133:   8b 15 04 00 00 00       mov    0x4,%edx         <-+
 139:   89 e0                   mov    %esp,%eax          |
 13b:   25 00 e0 ff ff          and    $0xffffe000,%eax   | !!!
 140:   8b 40 14                mov    0x14(%eax),%eax    |
 143:   25 00 00 ff 0f          and    $0xfff0000,%eax    |
 148:   85 d2                   test   %edx,%edx        <-+
 14a:   74 04                   je     150 <__local_bh_enable+0x20>
 14c:   85 c0                   test   %eax,%eax
 14e:   75 35                   jne    185 <__local_bh_enable+0x55>
 150:   89 e0                   mov    %esp,%eax
 152:   8b 0d 00 00 00 00       mov    0x0,%ecx         <-+
 158:   25 00 e0 ff ff          and    $0xffffe000,%eax   |
 15d:   8b 40 14                mov    0x14(%eax),%eax    | !!!
 160:   25 00 ff 00 00          and    $0xff00,%eax       |
 165:   3d 00 01 00 00          cmp    $0x100,%eax        |
 16a:   0f 94 c0                sete   %al                |
 16d:   85 c9                   test   %ecx,%ecx        <-+
 16f:   0f b6 c0                movzbl %al,%eax
 172:   74 04                   je     178 <__local_bh_enable+0x48>
 174:   85 c0                   test   %eax,%eax
 176:   75 42                   jne    1ba <__local_bh_enable+0x8a>
 178:   b8 00 01 00 00          mov    $0x100,%eax
 17d:   83 c4 10                add    $0x10,%esp
 180:   e9 fc ff ff ff          jmp    181 <__local_bh_enable+0x51>
 185:   c7 44 24 0c 3e 00 00    movl   $0x3e,0xc(%esp)
 ...

WARN_ON is better, but still has problems:

000011a0 <do_exit>:
    11a0:       55                      push   %ebp
    11a1:       57                      push   %edi
    11a2:       56                      push   %esi
    11a3:       53                      push   %ebx
    11a4:       83 ec 30                sub    $0x30,%esp
    11a7:       89 44 24 18             mov    %eax,0x18(%esp)
    11ab:       89 e0                   mov    %esp,%eax
    11ad:       25 00 e0 ff ff          and    $0xffffe000,%eax
    11b2:       8b 30                   mov    (%eax),%esi
    11b4:       8b 86 58 0a 00 00       mov    0xa58(%esi),%eax
    11ba:       89 44 24 2c             mov    %eax,0x2c(%esp)      <-+
    11be:       8b 44 24 2c             mov    0x2c(%esp),%eax      <-+
    11c2:       85 c0                   test   %eax,%eax              | !!!
    11c4:       0f 85 65 07 00 00       jne    192f <do_exit+0x78f>   |
    11ca:       8b 44 24 2c             mov    0x2c(%esp),%eax      <-+
    11ce:       89 e0                   mov    %esp,%eax
     ...

This is gcc (GCC) 4.0.3 (Ubuntu 4.0.3-1ubuntu5), -O2.

I don't know why this would show up as cache misses, but it does look
like a compiler bug is being tickled.

Andrew Wade
