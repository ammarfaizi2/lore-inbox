Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVANVIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVANVIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVANVHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:07:20 -0500
Received: from opersys.com ([64.40.108.71]:25350 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262168AbVANVET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:04:19 -0500
Message-ID: <41E8358A.4030908@opersys.com>
Date: Fri, 14 Jan 2005 16:11:38 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andi Kleen <ak@muc.de>, Nikita Danilov <nikita@clusterfs.com>,
       linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501141626310.6118@scrub.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Roman,

Roman Zippel wrote:
> You don't think that's a little overkill?

I can see why you'd say this as a first impression, but really it isn't.

Here's a simple primer to this call's parameters:
channel_path, mode:
	Where does this appear in relayfs and what rights do
	user-space apps have over it (rwx).
bufsize, nbufs:
	Usually things have to be subdivided in sub-buffers to make
	both writing and reading simple. LTT uses this to allow,
	among other things, random trace access.
channel_flags, channel_callbacks:
	General channel management (should we write over unread data,
	is data delivered in bulk or in units, what granularity of
	timestamping is required, who should we call to initialize/
	finalize the content of a sub-buffer.) All of these are used
	by LTT, for example, in a number of ways.
start_reserve, end_reserve, rchan_start_reserve:
	Some subsystems, like LTT, need to be able to write some key
	data at sub-buffer boundaries. This is to specify how much
	space is required for said data.
resize_min, resize_max:
	Allow for dynamic resizing of buffer.
init_buf, init_buf_size:
	Is there an initial buffer containing some data that should
	be used to initialize the channel's content. If you're doing
	init-time tracing, for example, you need to have a pre-allocated
	static buffer that is copied to relayfs once relayfs is mounted.

As you can see, most of this is already used in one way or another by
LTT. The only thing LTT doesn't use is the dynamic resizing, but as was
said earlier in this thread, some people actually want to have this.
If it really came to it, we could drop this and resubmit when somebody
actually requests this, but my understanding is that the previous poster
did indeed indicate his need for this.

> BTW it should return a pointer not an id, at every further access it needs 
> to be looked up, killing the effects of any lockless mechanism.

Sounds reasonable. We will review this.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
