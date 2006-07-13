Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWGMSB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWGMSB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWGMSB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:01:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10394 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964786AbWGMSB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:01:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
	<44B50088.1010103@fr.ibm.com>
	<m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	<44B684A5.2040008@fr.ibm.com>
Date: Thu, 13 Jul 2006 11:59:36 -0600
In-Reply-To: <44B684A5.2040008@fr.ibm.com> (Cedric Le Goater's message of
	"Thu, 13 Jul 2006 19:36:37 +0200")
Message-ID: <m1sll51j3r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> Eric W. Biederman wrote:
>
>>> I think user namespace should be unshared with filesystem. if not, the
>>> user/admin should know what is doing.
>> 
>> No.  The uids in a filesystem are interpreted in some user namespace
>> context.  We can discover that context at the first mount of the
>> filesystem. 
>
> ok. so once you're in such a user namespace, you can't unshare from it
> without loosing access to all your files ?

Any file that is accessible without needing specific user and group
permissions will still be accessible.  In essence you are an enhanced
version of the nobody user when you access files outside of your
namespace.  What you can't do is create files as you cannot be
represented on the filesystem.

>> Assuming the uids on a filesystem are the same set of uids your process
>> is using is just wrong.
>
> well, this is what is currently done without user namespaces.

Yes.  But the whole system is assumed to be in the same user namespace,
so that is a reasonable assumption.  Once we break that assumption we
need to do something different.  There are a few network filesystems
that are at least working on using keys to authenticate users.

>>>> I believe some of the key infrastructure which is roughly kerberos
>>>> authentication tokens could be used for this purpose.
>>> please elaborate ? i'm not sure to understand why you want to use the keys
>>> to map users.
>> 
>> keys are essentially security credentials for something besides the
>> local kernel.  Think kerberos tickets.  That makes the keys the
>> obvious place to say what uid you are in a different user namespace
>> and similar things.
>
> what about performance ? wouldn't that slow the checking ?

It needs to be looked at, but it shouldn't slow the same namespace
case, and permission checking is largely a slow path issue.  So a little
overhead at open time is preferred to overhead after you get the file
open.

Mapping users is clearly a separate problem, but related problem.  For
sharing read-only data that you don't mind sharing with everyone the
current set of semantics I have described is fine.  

Eric
