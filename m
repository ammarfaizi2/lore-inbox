Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314007AbSDKGqz>; Thu, 11 Apr 2002 02:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314008AbSDKGqy>; Thu, 11 Apr 2002 02:46:54 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:49420 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S314007AbSDKGqx>;
	Thu, 11 Apr 2002 02:46:53 -0400
Date: Thu, 11 Apr 2002 15:46:51 +0900 (JST)
Message-Id: <20020411.154651.51706443.taka@valinux.co.jp>
To: davem@redhat.com
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20020410.193045.32403941.davem@redhat.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Thank you for the replies.

ak>    From: Andi Kleen <ak@suse.de>
ak>    Date: 10 Apr 2002 21:32:22 +0200
ak> 
ak>    For hw checksums it should not be a problem. NICs usually load
ak>    the packet into their packet fifo and compute the checksum on the fly
ak>    and then patch it into the header in the fifo before sending it out. A
ak>    NIC that would do slow PCI bus mastering twice just to compute the checksum
ak>    would be very dumb and I doubt they exist (if yes I bet it would be
ak>    faster to do software checksumming on them). When the NIC only
ak>    accesses the memory once there is no race window.

davem> Aha, but in the NFS case what if the page in the page cache gets
davem> truncated from the file before the SKB is given to the card?
davem> It would be quite easy to add such a test case to connectathon :-)
davem> 
davem> See, we hold a reference to the page in the SKB, but this only
davem> guarentees that it cannot be freed up reused for another purpose.
davem> It does not prevent the page contents from being sent out long
davem> after it is no longer a part of that file.

I believe it's probably OK.  We considered as follows.

Please consider a knfsd sends data of File A by useing sendmsg().
  1. The knfsd copies the data of File A into sk_buff.
  2. File A may be truncated after step.1
  3. NFS clients receives the packets of File A which is already truncated.

Next please consider the knfsd sends data of File A by useing sendpage().
  1. The knfsd grabs pages of File A. (page_cache_get)
  2. File A may be truncated after step.1
  3. The knfsd send the pages.
  4. NFS clients receives the packets of File A which is already truncated.

Is there any differences between them ?
This behavior is invisible to NFS Clients, I think.

davem> Samba has similar issues, which is why they only use sendfile()
davem> when the client holds an OP lock on the file.  (Although the Samba
davem> issue is that in the same packet they mention the length of the file
davem> plus the contents).

I think NFSD is a part of kernel -- not a usermode process, so NFSD can
control to avoid this kind of situations.

New zerocopy knfsd grabs pages of file and its atrribute in a same operation.
I think no discrepancy between them would occur.

And yes I know sending pages might be overwritten by another process,
but it maybe also happens on local filesystems. File data can be
updated while another process is reading the same file.

davem> I'm still not %100 convinced this behavior would be illegal in the
davem> NFS case, it needs more deep thought than I can provide right now.

I'm happy to talk to you.

Thank you,
Hirokazu Takahashi
