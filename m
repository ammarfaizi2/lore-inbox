Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317002AbSGXMTW>; Wed, 24 Jul 2002 08:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316999AbSGXMTW>; Wed, 24 Jul 2002 08:19:22 -0400
Received: from unthought.net ([212.97.129.24]:35479 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S317002AbSGXMTV>;
	Wed, 24 Jul 2002 08:19:21 -0400
Date: Wed, 24 Jul 2002 14:22:32 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Joshua MacDonald <jmacd@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry repacement: generic_out_cast)
Message-ID: <20020724122232.GT11081@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Joshua MacDonald <jmacd@namesys.com>, linux-kernel@vger.kernel.org
References: <15677.33040.579042.645371@laputa.namesys.com> <20020723220745.GD2090@reload.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020723220745.GD2090@reload.namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 02:07:45AM +0400, Joshua MacDonald wrote:
...
> This may interest you.  We have written a type-safe doubly-linked list
> template which is used extensively in reiser4.  This is the kind of thing that
> some people like very much and some people hate, so I'll spare you the
> advocacy.

Ok, here's my comments:

*) Using macros like that is ugly as hell, but as I see it it is the
only way to achieve type safety in such generic code.  If the ugliness
is confined to one header file, and possibly one .c file containing the
needed instantiations, I would argue that the ugliness is bearable.  In
other words, I think your solution is the prettiest one possible.

Since all list routines right now are extremely simple, it's probably ok
to just have it all in a header. If larger routines are added later on,
it may be desirable to create a .c file holding the needed (macro
instantiated) routines. In that case, the following applies:

*) I would suggest making one list_instances.c which holds all the
INSTANTIATE... definitions of the list types needed in the kernel. This
way we will avoid having two list codes generated for the same type (an
easy accident to make with the macro approach)
*) You would have to somehow separate the "simple" routines which should
be inlined, and the larger ones which should remain function calls. This
would mean that a .c file using the list header would have the inline
functions declared in the list header (using static inline so unused
routines won't bloat the .o), and find it's larger out-of-line routines
in the global list .o.

The reason I'm suggesting doing the above instead of simply
instantiating a list implementation for each type needed, whenever it is
needed, is simply to avoid code bloat.

My only comment for the code would be to require that the link from the
element into the list would always be called "rx_list_backlink" or
whatever (if the list name is "rx_list") - the freedom you have in
specifying what the LINK_NAME is, is useless as I see it, and only adds
to the confusion.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
