Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312484AbSDEMLV>; Fri, 5 Apr 2002 07:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312489AbSDEMLL>; Fri, 5 Apr 2002 07:11:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8340 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312484AbSDEMLH>;
	Fri, 5 Apr 2002 07:11:07 -0500
Date: Fri, 05 Apr 2002 04:04:51 -0800 (PST)
Message-Id: <20020405.040451.127871174.davem@redhat.com>
To: stelian.pop@fr.alcove.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: socket write(2) after remote shutdown(2) problem ?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020405120054.GF16595@come.alcove-fr>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stelian Pop <stelian.pop@fr.alcove.com>
   Date: Fri, 5 Apr 2002 14:00:55 +0200

   As you can see, read() doesn't return any error, just 0 to 
   indicate end-of-file (seems correct interpretation of remote
   shutdown here), but it doesn't report any error from the 
   precedent write... Bug ?

Race, wait a bit, the reset will arrive.

This is a error state in your code, writing when the server expects no
data.  Always remember that when you are trying to judge if
whatever socket operation results is valid or invalid.
   
Since we find out about the reset asynchronously, this is what
happens.

   > But all of this is irrelevant.  When a server closes and says "send me
   > no more data", this implies that the server told the client it doesn't
   > want any more data.
   
   Perfectly valid but only if the 'applicative close' has reached the
   other end. If it's still queued in TCP buffers, the client may not
   have received yet that close... I thought that this was the only
   reason that shutdown() existed at all: flush the buffers preparing
   an imminent close...

Not a close "in TCP" but a close "in your apps protocol".
As in:

	write(socket_fd, "Ok client I have all your data, lets close now")

See?  If the server closes without telling the client that, all
bets are off.

Look, your app is buggy, PERIOD.  Once you start to write to a closed
socket, sorry the phase of the moon decides what happens to you.  Most
of the time you'll be lucky and see an error.
