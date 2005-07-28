Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVG1SJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVG1SJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVG1SD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:03:59 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:6138 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261870AbVG1SDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:03:43 -0400
Date: Thu, 28 Jul 2005 11:09:07 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Greg KH <greg@kroah.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050728180907.GI9985@gaz.sfgoth.com>
References: <20050726015401.GA25015@kroah.com> <9e473391050725201553f3e8be@mail.gmail.com> <9e47339105072719057c833e62@mail.gmail.com> <20050728034610.GA12123@kroah.com> <9e473391050727205971b0aee@mail.gmail.com> <20050728040544.GA12476@kroah.com> <9e47339105072721495d3788a8@mail.gmail.com> <20050728054914.GA13904@kroah.com> <20050728070455.GF9985@gaz.sfgoth.com> <9e47339105072805545766f97d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105072805545766f97d@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Thu, 28 Jul 2005 11:09:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> Do we need to deal with UTF8 here? I did the forward loop because you
> can't parse UTF8 backwards. If UTF8 is possible I need to change the
> pointer inc function.

As others have mentioned there shouldn't be a UTF8 problem with isspace().
However, even if you wanted to scan going forwards you can do it without
the complexity of a nested loop:

	char *real_end;

	for (real_end = x; x - buffer->page < count; x++)
		if (!isspace(*x))
			real_end = x + 1;
	*real_end = '\0';
	// then fix "count"

BTW, my code I posted yesterday is incomplete since I neglected to notice
that the "count = z - x" at the end is used to repair "count" damage from
both the leading and trailing whitespace stripping.  Its actually easier
to strip the trailing whitespace first, like:

	while (count > 0 && isspace(buffer->page[count - 1]))
		count--;	/* strip trailing whitespace */
	if (count > 0 && isspace(buffer->page[0])) {
		/*
		 * We have leading whitespace but also at least one
		 * non-whitespace character
		 */
		const char *x = buffer->page;
		do {
			x++;
			count--;
		} while (isspace(*x));
		memmove(buffer->page, x, count);
	}
	buffer->page[count] = '\0';

-Mitch
