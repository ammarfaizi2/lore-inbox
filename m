Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVEFI5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVEFI5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 04:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVEFI5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 04:57:54 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:24535 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261191AbVEFI5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 04:57:51 -0400
Message-ID: <427B333F.5A0BB431@tv-sign.ru>
Date: Fri, 06 May 2005 13:05:03 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Priority Lists for the RT mutex
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
>
> Description:
> 	This patch adds the priority list data structure from Inaky Perez-Gonzalez 
> to the Preempt Real-Time mutex.
>
> ...
>
> +#define plist_for_each(pos1, pos2, head)	\
> +	list_for_each_entry(pos1, &((head)->dp_node), dp_node)	\
> +		list_for_each_entry(pos2, &((pos1)->sp_node), sp_node)

I can't understand how this can work.

The fist list_for_each_entry(->dp_node) will iterate over nodes
with different priorities, ok. But the second one will skip the
first node (which starts new priority group), because list_for_each(head)
does not count head.

To be sure, I wrote simple test:

#include <stdio.h>
#include <limits.h>
#include "list.h"
#include "plist.h"

int main(void)
{
	struct plist head, node, *pos1, *pos2;

	plist_init(&head, 0);
	plist_init(&node, 0);

	plist_add(&node, &head);

	plist_for_each(pos1, pos2, &head)
		printf("Strange ???\n");

	return 0;
}

Prints nothing.

My apologies if I'm misunderstanding something.

Oleg.
