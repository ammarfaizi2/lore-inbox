Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268232AbUIBSQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268232AbUIBSQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 14:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268227AbUIBSQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 14:16:43 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:63925 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268216AbUIBSQf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 14:16:35 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Tonnerre <tonnerre@thundrix.ch>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, spam@tnonline.net,
       akpm@osdl.org, wichert@wiggy.net, jra@samba.org, torvalds@osdl.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com, vonbrand@inf.utfsm.cl
Subject: Re: silent semantic changes with reiser4
References: <20040829191044.GA10090@thundrix.ch>
	<3247172997-BeMail@cr593174-a> <20040831081528.GA14371@thundrix.ch>
	<20040901201608.GD31934@mail.shareable.org>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 02 Sep 2004 20:16:33 +0200
In-Reply-To: <20040901201608.GD31934@mail.shareable.org>
Message-ID: <m3u0ugilj2.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> (For example, if I edit an HTML file which is encoded in iso-8859-1,
> change it to utf-8 and indicate that in a META element, and save it
> under the same name, the full content-type should change from
> "text/html; charset=iso-8859-1" to "text/html; charset=utf-8".)
>
> I don't see how you can do that without kernel support.

charset_cache = dbm(os.getenv('HOME') + '/.charset_cache')

def get_charset(path):
    file_mtime = get_mtime(path)
    cache_tuple = dbm.get(path, (None, None))
    if file_mtime != cache_tuple[0]:
        cache_tuple = (file_mtime, figure_out_charset(path))
        dbm.put(path, cache_tuple)
    return cache_tuple[1]

This code is guaranteed to always give you an up to date charset for a
file, provided that the mtime is guaranteed to change every time the
file changes.

If the file can change during the call to get_charset you'll have to
lock the file while you are working with it or handle it some other
way (comparing mtime before and after and retrying if they differ),
but that is true even if you do it all in the kernel.  This has the
added advantage that the cache is updated lazily, so the charset is
never calculated unless someone really needs it.

If the disk gets full, it is time to shrink the cache and preferably
stale entries are evicted first.  If that's not good enough, a
notifier such as dnotify or inotify can be used to invalidate the
cache immediately after the file has changed.

If this gets popular, the cache management can be moved to a daemon
(naturally with all the security aspects in mind). 

> Don't say dnotify or inotify, because neither would work.

Why not?  The approach above works on any filesystem, even without
dnotify or inotify but will be more efficient with them.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
