Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269817AbRHMFZ7>; Mon, 13 Aug 2001 01:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269819AbRHMFZt>; Mon, 13 Aug 2001 01:25:49 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:38299 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S269817AbRHMFZj>;
	Mon, 13 Aug 2001 01:25:39 -0400
Message-ID: <3B7764DF.BF58692D@candelatech.com>
Date: Sun, 12 Aug 2001 22:25:51 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Low-Cost IP TOS bit won't clear.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm doing some experimenting with setting the various values of
the IP TOS byte.  First (as I already mentioned on the linux-net
mailing list) the IPTOS_* values in netinet/ip.h do not seem
correct, they should be shifted left by 2 bits each, if I understand
correctly...

However, even if that is a bug, it is easily fixable in user space
by just passing our own values to the setsockopt() method.

There does seem to be a bug with setsockopt and/or IP itself.
If I ever set the Cost TOS bit (0x80), then I cannot clear it,
even by setting the TOS byte to zero.  If I do attempt to set
the byte to zero, getsockopt shows that it was really set to 2.

(I'm beginning to think I should be using htonl or something
 like that, but I don't think that explains the failure to set
 to zero....)

My method to set/get is:

int BtbitsIpEndpoint::doSetTos() {
   // Set IP ToS
   if (dev_socket >= 0) {
      int val = tos;
      VLOG_DBG(VLOG << "Setting TOS to: " << val << endl);
      if (setsockopt(dev_socket, SOL_IP, IP_TOS, (char*)&val, sizeof(int)) < 0) {
         VLOG_ERR(VLOG << "ERROR:  tcp-start, setsockopt TOS:  " << strerror(errno) << endl);
         return -1;
      }//if
      
      int new_val = 0;
      socklen_t slt = sizeof(int);
      if (getsockopt(dev_socket, SOL_IP, IP_TOS, (void*)(&new_val), &slt) < 0) {
         VLOG_ERR(VLOG << "ERROR:  tcp-start, getsockopt TOS:  " << strerror(errno) << endl);
         return -1;
      }//if
      else {
         if (val != new_val) {
            VLOG_WRN(VLOG << "Didn't set TOS as desired, requested: " << tos << " current is: "
                     << new_val << endl);
            tos = new_val;
            real_tos = new_val;
         }
      }
   }
   return 0;
}//doSetTos

Any ideas will be appreciated...

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
