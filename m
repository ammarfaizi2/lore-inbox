Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTIPJHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 05:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTIPJHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 05:07:23 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:47736 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261801AbTIPJHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 05:07:22 -0400
Date: Tue, 16 Sep 2003 05:07:16 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, jgarzik@pobox.com
Subject: Re: Add function attribute to copy_from_user to warn for unchecked results
Message-ID: <20030916050716.W11756@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20030916100729.B19768@devserv.devel.redhat.com> <20030916012632.2fb67701.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030916012632.2fb67701.akpm@osdl.org>; from akpm@osdl.org on Tue, Sep 16, 2003 at 01:26:32AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 01:26:32AM -0700, Andrew Morton wrote:
> Arjan van de Ven <arjanv@redhat.com> wrote:
> >
> > Hi,
> > 
> > gcc 3.4 (CVS) has a new function attribute (warn_unused_result) that
> > will make gcc spit out a warning in the event that a "marked" function's
> > result is ignored by the caller.
> 
> Nice.

Note that for macros like get_user something like this should be used
(as the attribute is only for functions):

extern inline __must_check int check_int_result (int arg) { return arg; }

#define get_user(x,ptr)                                                 \
check_int_result ( ({							\
	int __ret_gu,__val_gu;                                          \
        switch(sizeof (*(ptr))) {                                       \
        case 1:  __get_user_x(1,__ret_gu,__val_gu,ptr); break;          \
        case 2:  __get_user_x(2,__ret_gu,__val_gu,ptr); break;          \
        case 4:  __get_user_x(4,__ret_gu,__val_gu,ptr); break;          \
        default: __get_user_x(X,__ret_gu,__val_gu,ptr); break;          \
        }                                                               \
        (x) = (__typeof__(*(ptr)))__val_gu;                             \
        __ret_gu;                                                       \
}) )

	Jakub
