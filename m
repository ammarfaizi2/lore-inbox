Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVK1UIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVK1UIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVK1UIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:08:35 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:61096 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932233AbVK1UIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:08:34 -0500
Message-ID: <438B710B.8090509@austin.rr.com>
Date: Mon, 28 Nov 2005 15:05:15 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: inode_change_ok
References: <438B42F3.1040006@austin.rr.com> <1133197587.27574.19.camel@lade.trondhjem.org> <1133198114.27574.23.camel@lade.trondhjem.org> <438B4FC6.1080506@austin.rr.com> <1133201349.27574.56.camel@lade.trondhjem.org> <438B5F6E.70702@austin.rr.com> <1133205191.27574.83.camel@lade.trondhjem.org>
In-Reply-To: <1133205191.27574.83.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>CAP_CHOWN would therefore only be useful in the corner case where the
>server is allowing full root privileges to a client, and where the
>client is using capabilities to limit the root account's (or a setuid
>processes') ability to exercise those full privileges.
>
>Cheers,
>  Trond
>
>
>  
>
It sounds like I do need to make the change to cifs to add the optional 
(based on the mount parm the admin can choose which model) call to 
inode_change_ok to make the permissions check consistent when "noperm" 
is not enabled on that mount , but I was trying to figure out how 
important that change to the cifs code was and whether it was a priority 
to get in.  I realize that this corner case is far less common in the 
wild for nfs.  The corner case you describe above did seem to come up 
today for cifs though (where the admin had in effect, trusted the 
client, and allowed the client to mount as root with full root priv on 
the server - I can imagine this being valid in their particular case, 
with a trusted client os, over a trusted lan, but obviously would not be 
the most common scenario).  Obviously they did not turn on 
multiusermount in /proc/fs/cifs (ie the ability to send different uids 
on the wire depending on the uid of the client calling process) so the 
only perm check that would be useful that was occuring at the client the 
way they had chosen to configure/mount was happening in 
generic_permission in the client.   In their particular configuration 
open and other paths in the vfs that call permission behaved fine and 
the permission checks worked as expected - but chown always worked 
(which is of course wrong) since the vfs does not call permission but 
expects the vfs (if at all) to call inode_change_ok - so open failing, 
but chown working was confusing to them.

Of course it does not make it much easier trying to compare with other 
filesystems - ncpfs does seem to call both (generic_permission 
inode_change_ok) and but the afs model (openafs) is far more complicated 
and somewhat confusing (and interestingly afs does not call 
generic_permission but does call inode_change_ok) so it is not really 
possible to draw too many conclusions for how afs approached the same 
two usage models (apparently afs also had a third usage model based on 
machine address)

