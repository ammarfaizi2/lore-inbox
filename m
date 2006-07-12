Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWGLOhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWGLOhR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWGLOhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:37:17 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:58708 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750954AbWGLOhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:37:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eaIBSScLCtmH6NKo4dpRbafi/ERIW6r/Ju2hp1nXeZx90ODU3Wd20ndYZtYPhn0NeURWPBBqRXO3TDl3fSIgqATxCrzPzY2anV01OamSlbqIh78Yj8SBMip8pDgztsef6jrtDxraCjKqcy0dKdFKJA9r6FWf0pOUKjf/b+2z3FA=
Message-ID: <b0943d9e0607120737h691212ddl31d5db4bb1cb3db4@mail.gmail.com>
Date: Wed, 12 Jul 2006 15:37:15 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607120619p6837a64bice7808856f93b11b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110649s464840a9sf04c7537809436b1@mail.gmail.com>
	 <b0943d9e0607110702p60f5bf3fg910304bfe06ec168@mail.gmail.com>
	 <6bffcb0e0607110802w4f423854rb340227331084596@mail.gmail.com>
	 <b0943d9e0607110844m6278da6crdc03bccce420da1d@mail.gmail.com>
	 <6bffcb0e0607110902u4e24a4f2jc6acf2eb4c3bae93@mail.gmail.com>
	 <b0943d9e0607110931n4ce1c569x83aa134e2889926c@mail.gmail.com>
	 <6bffcb0e0607111000q228673a9kcbc6c91f76331885@mail.gmail.com>
	 <b0943d9e0607111454l1f9919eahbb3b683492a651e@mail.gmail.com>
	 <6bffcb0e0607120619p6837a64bice7808856f93b11b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Here is a slabinfo from current 2.6.18-rc1-git4 and 2.6.18-rc1 +
> kmemleak http://www.stardust.webpages.pl/files/o_bugs/kml/slab.txt

Thanks. Does it make any difference if you enable
CONFIG_DEBUG_MEMLEAK_TASK_STACKS? Also, if you save the memleak file
periodically, do any of the context_struct_to_string reports disappear
(I can investigate this if you upload a few ml60.txt, mk61.txt etc.)?

> I haven't seen that before
> orphan pointer 0xf1283e34 (size 224):
>   c01735c2: <kmem_cache_alloc>
>   fdc8c5cf: <ip_conntrack_alloc>
>   fdc8c6a3: <init_conntrack>
>   fdc8c894: <ip_conntrack_in>
>   fdc8b652: <ip_conntrack_local>
>   c02c15bf: <nf_iterate>
>   c02c1630: <nf_hook_slow>
>   c02e127e: <raw_send_hdrinc>

This looks like a false positive as the conntrack pointer is lost in
init_conntrack and only a pointer conntrack->tuplehash[...].list is
stored. This cannot be aliased via container_of because
tuplehash_to_ctrack doesn't pass a constant argument to it and cannot
be determined at compile time. Try the attached patch.

Note that you can get some false positives that might disappear after
a while. This is because of the stacks scanning and also pointers
stored in CPU registers, especially on SMP systems.

Thanks.

-- 
Catalin
