Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312491AbSDEMB2>; Fri, 5 Apr 2002 07:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312484AbSDEMBT>; Fri, 5 Apr 2002 07:01:19 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:59786 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S312488AbSDEMBH>; Fri, 5 Apr 2002 07:01:07 -0500
Date: Fri, 5 Apr 2002 14:00:55 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: socket write(2) after remote shutdown(2) problem ?
Message-ID: <20020405120054.GF16595@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020405104733.GD16595@come.alcove-fr> <20020405.024435.88131177.davem@redhat.com> <20020405105509.GE16595@come.alcove-fr> <20020405.030251.28451401.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 03:02:51AM -0800, David S. Miller wrote:

>    From: Stelian Pop <stelian.pop@fr.alcove.com>
>    Date: Fri, 5 Apr 2002 12:55:09 +0200
>    
>    > 	* client socket receives a TCP reset
>    
>    How is the client socket supposed to know it received a TCP reset
>    (I am talking from the application point of view, not the kernel...) ?
> 
> You may find out by attempting to read data, or you may use the
> extended IP error reporting Linux has.

In the client, I've added a read(fd, buf, 1) just after the write,
and rerun:

	client				server

	...				...
					shutdown()
	...		
lsof will shown the client socket being in CLOSE_WAIT at this point
					...
	write(fd, buf, 5) = 5
	read(fd, buf, 1) = 0
	...
	exit(0)
					exit(0)

As you can see, read() doesn't return any error, just 0 to 
indicate end-of-file (seems correct interpretation of remote
shutdown here), but it doesn't report any error from the 
precedent write... Bug ?

> But all of this is irrelevant.  When a server closes and says "send me
> no more data", this implies that the server told the client it doesn't
> want any more data.

Perfectly valid but only if the 'applicative close' has reached the
other end. If it's still queued in TCP buffers, the client may not
have received yet that close... I thought that this was the only
reason that shutdown() existed at all: flush the buffers preparing
an imminent close...

> If the client sends data, this is a gross fatal
> error, so TCP resets in FIN_WAIT{1,2} states.
> 
> RFC 793 originally specified to queue the data, RFC 1122 is where
> the current behavior is defined.

Thanks for the pointer. 

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
