Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTIPMEF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 08:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbTIPMEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 08:04:05 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:65288 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261895AbTIPMEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 08:04:01 -0400
Date: Tue, 16 Sep 2003 14:03:58 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030916140358.A1561@pclin040.win.tue.nl>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>; from dychen@stanford.edu on Mon, Sep 15, 2003 at 09:35:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 09:35:46PM -0700, David Yu Chen wrote:

> I'm with the Stanford Meta-level Compilation research group, and I
> have a set of memory leaks on error paths for the 2.6.0-test5 kernel.

There is no memory leak in the below:

> ---------------------------------------------------------
> 
> [FILE:  2.6.0-test5/drivers/char/vt_ioctl.c]
> [FUNC:  do_kdsk_ioctl]
> [LINES: 133-150]
> [VAR:   key_map]
>  128:
>  129:			if (keymap_count >= MAX_NR_OF_USER_KEYMAPS &&
>  130:			    !capable(CAP_SYS_RESOURCE))
>  131:				return -EPERM;
>  132:
> START -->
>  133:			key_map = (ushort *) kmalloc(sizeof(plain_map),
>  134:						     GFP_KERNEL);
>  135:			if (!key_map)
>  136:				return -ENOMEM;
>  137:			key_maps[s] = key_map;
>  138:			key_map[0] = U(K_ALLOCATED);
>         ... DELETED 6 lines ...
>  145:			break;	/* nothing to do */
>  146:		/*
>  147:		 * Attention Key.
>  148:		 */
>  149:		if (((ov == K_SAK) || (v == K_SAK)) && !capable(CAP_SYS_ADMIN))
> END -->
>  150:			return -EPERM;
>  151:		key_map[i] = U(v);
>  152:		if (!s && (KTYP(ov) == KT_SHIFT || KTYP(v) == KT_SHIFT))
>  153:			compute_shiftstate();
>  154:		break;
>  155:	}

Explanation:
The user may have up to 256 keymaps, namely the plain map and
various maps for (combinations of) modifier keys.
In order to save memory, most of these keymaps will not be allocated.
If one sets an entry on a keymap, then first the keymap itself is
allocated in case it did not exist yet. Then the entry is filled,
assuming one has permission.
On the error path the memory is not lost: the pointer was stored
in the array key_maps[], so also am automatic checker could see that.
(And indeed, it is also possible to deallocate keymaps.)

Andries

