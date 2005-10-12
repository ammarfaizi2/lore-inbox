Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbVJLUEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbVJLUEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 16:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbVJLUEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 16:04:51 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:37998 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1751530AbVJLUEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 16:04:50 -0400
Message-ID: <434D6CFA.4080802@suse.com>
Date: Wed, 12 Oct 2005 16:07:22 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
References: <20051010204517.GA30867@br.ibm.com>  <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>  <20051010214605.GA11427@br.ibm.com>  <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>  <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk>  <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz> <1129017155.12336.4.camel@imp.csi.cam.ac.uk> <434D6932.1040703@suse.com> <Pine.LNX.4.62.0510122155390.9881@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.62.0510122155390.9881@artax.karlin.mff.cuni.cz>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mikulas Patocka wrote:
>> Anton Altaparmakov wrote:
>>> On Tue, 2005-10-11 at 00:49 +0200, Mikulas Patocka wrote:
>>>> On Mon, 10 Oct 2005, Anton Altaparmakov wrote:
>>>> What should a filesystem driver do if it can't suddenly read or
>>>> write any
>>>> blocks on media?
>>>
>>> Two clear choices:
>>>
>>> 1) Switch to read-only and use the cached data to fulfil requests and
>>> fail all others.
>>>
>>> 2) Ask the user to insert the media/plug the device back in (this is by
>>> far the most likely cause of all requests suddenly failing) and then
>>> continue where they left off.
>>>
>>> It is unfortunate that Linux does not allow for 2) so you need to do 1).
>>
>> I recently looked into 2) a bit and the dm multipath code is almost
>> enough to do exactly this.
>>
>> If you configure your block device as an mpath device that queues on
>> path failure, and change the table to the new device location on device
>> re-attach, the queued up i/o will be flushed out. Almost. Right now,
>> when you change the table and resume the dm mapping, it does a suspend
>> which attempts to write out the data to a device which is no longer
>> there, causing it to just be dropped on the floor. If this were changed
>> not to do that, and perhaps set a timer so that the dirty data wouldn't
>> be left around forever if the device wasn't reattached, 2) would
>> definitely be possible.
>>
>> I realize that the userspace intervention required may involve a bit of
>> dark magic, but my point is most of the code required on the kernel side
>> is already implemented.
>>
>> - -Jeff
> 
> Is memory management ready for this? Can't deadlock like this happen?
> - displaying dialog window needs memory, so it waits until memory will
> be available
> - system decides to write some write-back cached data in order to free
> memory
> - the write of these data waits until the dialog window is displayed,
> user inserts the device and clicks 'OK'

No, it's not, and deadlock is definitely possible. However, if we're at
the point where memory is tight enough that it's an issue, the timer can
expire and all the pending i/o is dropped just as it would be without
the multipath code enabled.

I'm not saying it's a solution ready for production, just a good
starting point.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDTWz5LPWxlyuTD7IRAiXRAJ4oRz7NpSrhMxp1ODlJWFsDaBcMsgCfbB8q
3XoPFrF0XHA1NFInVSjRicw=
=Do4z
-----END PGP SIGNATURE-----
