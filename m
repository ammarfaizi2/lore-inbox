Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTJDBg6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 21:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbTJDBg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 21:36:58 -0400
Received: from 12-207-41-15.client.attbi.com ([12.207.41.15]:45584 "EHLO
	skarpsey.home.lan") by vger.kernel.org with ESMTP id S261695AbTJDBg5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 21:36:57 -0400
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Alpha (EV56), lseek64, and /dev/kmem
Date: Fri, 3 Oct 2003 20:36:29 -0500
User-Agent: KMail/1.5.2
References: <200310031942.50234.kelledin+LKML@skarpsey.dyndns.org> <yw1x7k3lajx4.fsf@users.sourceforge.net>
In-Reply-To: <yw1x7k3lajx4.fsf@users.sourceforge.net>
Cc: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=)
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310032036.29519.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 October 2003 08:08 pm, Måns Rullgård wrote:
> /dev/kmem hasn't anything to do with filesystems, right?

I suspected as much.

After a bit of consideration and some poking around the kernel 
source, I'm guessing the vfs layer interprets any negative value 
from an llseek vfsop as an error condition (even if it's just a 
very large 64-bit offset).  Obviously this wouldn't be a problem 
for most stuff--as you say, I doubt any fs (virtual or 
non-virtual) was intended to support such large files.  This 
situation with /dev/kmem on 64-bit machines is just an 
exceptional (and exceptionally annoying) corner case.

So far I see three possibilities:

1) fix the VFS layer so it accepts certain very large 64-bit 
quantities as valid quantities.  This would probably be a 
significant kernel rework...and I hate that, especially on an 
already-released stable branch (i.e. 2.4) or a branch very close 
to pre-release (i.e. 2.5/2.6).  I'd say save this for 2.7 and 
take care of it then.

2) migrate klogd to use query_module() rather than stepping 
through /dev/kmem.  query_module() should provide everything 
that klogd normally pokes around /dev/kmem for.  Does it rely 
indirectly on being able to step through kmem?  I hope not...

3) switch to a system/kernel logger that already supports 
query_module().  is there such a beast?  is there, perhaps, a 
patch for the de facto sysklogd?

Who maintains sysklogd-1.4.1, anyways?  It seems to be a fairly 
antiquated hunk of junk...

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"

