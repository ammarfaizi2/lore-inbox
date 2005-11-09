Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbVKIT24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbVKIT24 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbVKIT24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:28:56 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:8106 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030386AbVKIT2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:28:55 -0500
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
From: Ram Pai <linuxram@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0511091054290.3247@g5.osdl.org>
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk>
	 <E1EZUC9-0007oJ-00@dorka.pomaz.szeredi.hu>
	 <1131464926.5400.234.camel@localhost>
	 <E1EZVoO-000807-00@dorka.pomaz.szeredi.hu>
	 <1131561849.5400.384.camel@localhost>
	 <Pine.LNX.4.64.0511091054290.3247@g5.osdl.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1131564500.5400.407.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Nov 2005 11:28:20 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 10:59, Linus Torvalds wrote:
> On Wed, 9 Nov 2005, Ram Pai wrote:
> >
> > And 'umount .' really doen't make sense. What does it mean? umount the 
> > current mount? or umount of the mount that is mounted on this dentry?
> 
> "umount <directory>" _absolutely_ makes sense, whether "directory" is "." 
> or something else. People do it all the time.

ok. so you say 'umount <dir>' means umount something mounted on top of
dir.  In that case, when I say 'umount /tmp' it has to unmount something
that is mounted on top of /tmp, but there cannot be anything mounted on
top of /tmp. In the first place I cannot reach this mount since it is
obscured by the mount on top. right?

eg:  m1 is the root mount
     m2 is the mount on top of tmp on the root mount
     m3 is the mount on top of tmp(root dentry) of m2

'umount /tmp' 
will mean umount something that is mounted on top of root dentry of m3.



> 
> Now, if it doesn't unmount the last thing mounted on top of ".", then 
> that's a misfeature. It might be a misfeature in the mount program (it 
> might scan /etc/mounts top-to-bottom rather than the other way), but the 
> kernel should also support it.
> 
> > no. I said application _should_not_ depend on it, because it is a
> > undefined semantics.
> 
> It's definitely neither unusual nor undefined. I do all my umounts by 
> directory (in fact, doing it by anything else really _is_ badly defined, 
> since a block device can be mounted in many places), and the only sane 
> semantics would be to peel off the last mount on that directory.
> 
> Now, that doesn't necessarily mean that "list_add_tail()" is wrong. But 
> if we add new mounts to the end, then umount remove them from the end too, 
> no?

Yes it does. it removes the mounts that receive propagation from the
tail.  Anything that has been asked to be unmounted explicitly will be
removed irrespective of where it is on the list, and always it is at the
head because lookup_mnt() always returns the one at the head.

RP
> 
> 		Linus

