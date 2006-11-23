Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933284AbWKWIyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933284AbWKWIyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933297AbWKWIyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:54:04 -0500
Received: from smtp-out.google.com ([216.239.45.12]:28406 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S933284AbWKWIyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:54:01 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=cWUjD6H3gevL9RYbpKTIVjvFKU7MDqdjuCSZp0mBLZ5OBMGPzf4fatSaGgdQm3dm7
	rDGI1UVETSpgZRMzcDhLQ==
Message-ID: <6599ad830611230053m7182698cu897abe5d19471aff@mail.gmail.com>
Date: Thu, 23 Nov 2006 00:53:51 -0800
From: "Paul Menage" <menage@google.com>
To: "Pavel Emelianov" <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH 4/13] BC: context handling
Cc: "Kirill Korotaev" <dev@sw.ru>, "Andrew Morton" <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       matthltc@us.ibm.com, hch@infradead.org,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, oleg@tv-sign.ru,
       devel@openvz.org
In-Reply-To: <45655D3E.5020702@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45535C18.4040000@sw.ru> <45535E11.20207@sw.ru>
	 <6599ad830611222348o1203357tea64fff91edca4f3@mail.gmail.com>
	 <45655D3E.5020702@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/06, Pavel Emelianov <xemul@openvz.org> wrote:
>
> We can do the following:
>
>   if (tsk == current)
>       /* fast way */
>       tsk->exec_bc = bc;
>   else
>       /* slow way */
>       stop_machine_run(...);
>
> What do you think?

How about having two pointers per task:

- exec_bc, which is the one used for charging
- real_bc, which is the task's actual beancounter

at the start of irq, do

current->exec_bc = &init_bc;

at the end of irq, do

current->exec_bc = current->real_bc;

When moving a task to a different bc do:

task->real_bc = new_bc;
atomic_cmpxchg(&task->exec_bc, old_bc, new_bc);

(with appropriate memory barriers). So if the task is in an irq with a
modified exec_bc pointer, we do nothing, otherwise we update exec_bc
to point to the new real_bc.

Paul
