Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbRFZWBW>; Tue, 26 Jun 2001 18:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265084AbRFZWBN>; Tue, 26 Jun 2001 18:01:13 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:7073 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S265077AbRFZWBA>;
	Tue, 26 Jun 2001 18:01:00 -0400
Message-ID: <3B39061A.4CFE75E8@candelatech.com>
Date: Tue, 26 Jun 2001 15:00:58 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-net <linux-net@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Does select (for write) work on PACKET_SOCKETs ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It does not seem to work for me like I want it to.  Basically,
it seems that it always takes the entire timeout (50-80 ms in my
case), but at least the socket descriptor is SET when select returns.  I want
it to return as soon as the socket is writable, which at low (56kbps)
speed on a 100bt NIC should be immediate, or certainly less than 50ms.

I'm using kernel 2.4.6-pre3 with RH 7.1.

Here is a snippet of code that does the socket creation (I am binding in this case.):

int createPacketSocket(const char* dev_name, int ether_type, int dev_idx, int should_bind) {
   LF_TRC_IN;
   VLOG << "dev_name -:" << dev_name << ":- dev_idx: " << dev_idx 
        << " type (decimal): " << ether_type << endl;

   int s = socket(PF_PACKET, SOCK_RAW, htons(ether_type));
   int r; //retval

   if (s < 0) {
      cerr << "ERROR: socket:  " << strerror(errno) << endl;
      VLOG << "ERROR: socket:  " << strerror(errno) << endl;
      return s;
   }

   if (should_bind) {
      struct sockaddr_ll myaddr;

      memset(&myaddr, '\0', sizeof(myaddr));
      myaddr.sll_family = AF_PACKET;
      myaddr.sll_protocol = htons(ether_type);
      myaddr.sll_ifindex = dev_idx;
      //strcpy(myaddr.sa_data, dev_name);
      
      r = bind(s, (struct sockaddr*)(&myaddr), sizeof(myaddr));
      if (r < 0) {
         cerr << "ERROR: bind:  " << strerror(errno) << endl;
         VLOG << "ERROR: bind:  " << strerror(errno) << endl;
         return r;
      }
   }

   nonblock(s);
   return s;
}


Any ideas?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
