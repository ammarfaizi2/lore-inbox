Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263588AbUDTQ0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbUDTQ0T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 12:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUDTQ0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 12:26:16 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:64679 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S263184AbUDTQZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 12:25:19 -0400
Message-ID: <40854EEC.8020508@candelatech.com>
Date: Tue, 20 Apr 2004 09:25:16 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Re: Testing Dual Ethernet via Loopback]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this message failed to go through the first time...


-------- Original Message --------
Subject: Re: Testing Dual Ethernet via Loopback
Date: Mon, 19 Apr 2004 18:44:27 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
To: Nick Popoff <cryptic-lkml@bloodletting.com>
CC: linux-kernel@vger.kernel.org
References: <200404190614.21764.cryptic-lkml@bloodletting.com>

Nick Popoff wrote:
> Greetings,
> 
> I am trying to write some software to test a dual port ethernet card.  I
> was hoping to be able to use an ethernet cable to just connect the
> ethernet board to itself and then write a program that talks to itself to
> make sure that both ports are working.  However, I've noticed that Linux
> is smart enough to realize it is talking to its own IP address, and it
> just delivers the data internally rather than use the network hardware at
> all.
> 
> So what I'm wondering is if there is a way to force Linux to actually
> utilize its network hardware in sending these packets to itself?  In other
> words, a ping or file transfer from an IP assigned to eth0 to another IP
> assigned to eth1 should fail if I unplug the network cable connecting the
> two.  Any advice on this would be much appreciated.  I'm not afraid of
> reading kernel source but have no idea where to start on this one.
> 
> I'm using 2.4.22 but would use any 2.4 or 2.6 kernel that supported this
> behavior. The National Semiconductor DP83815 (natsemi.o) is the 
> ethernet chipset.

You can apply the candela* patch from http://www.candelatech.com/~greear/vlan.html
and then use SO_BINDTODEVICE with something similar to this, where dev_to_bind_to
is a local interface, like "eth2":

int createTcpSocket(unsigned int ip_addr, int ip_port, const char* dev_to_bind_to) {
    LF_TRC_IN_NT;
    VLOG_DBG(VLOG << "ip_addr -:" << ip_addr << ": ip_port: " << ip_port << endl);
    char *opt;

    int s = socket(AF_INET, SOCK_STREAM, 0);

    VLOG_INF(VLOG << "createTcpSocket:  ip_addr -:" << ip_addr << ":  " << toStringIP(ip_addr)
             << ": ip_port: " << ip_port << " socket: " << s << endl);

    if (s < 0) {
       cerr << "ERROR: tcp socket:  " << strerror(errno) << endl;
       VLOG << "ERROR: tcp socket:  " << strerror(errno) << endl;
       return s;
    }

    if (setsockopt(s, SOL_SOCKET, SO_REUSEADDR, (char*)&opt,
                   sizeof(opt)) < 0) {
       cerr << "ERROR:  setsockopt:  " << strerror(errno) << endl;
       LFEXIT(100);
    }//if

    if (dev_to_bind_to) {
       // Bind to specific device.
       if (setsockopt(s, SOL_SOCKET, SO_BINDTODEVICE,
                      dev_to_bind_to, DEV_NAME_LEN + 1)) {
          VLOG_ERR(VLOG << "ERROR:  tcp-connect, setsockopt (BINDTODEVICE):  "
                   << strerror(errno) << "  Not fatal in most cases..continuing...\n");
       }
    }//if

    struct sockaddr_in my_ip_addr;
    memset(&my_ip_addr, 0, sizeof(my_ip_addr));

    my_ip_addr.sin_family = AF_INET;
    my_ip_addr.sin_addr.s_addr = htonl(ip_addr);
    my_ip_addr.sin_port = htons(ip_port);

    int r; //retval
    r = bind(s, (struct sockaddr*)(&my_ip_addr), sizeof(my_ip_addr));
    if (r < 0) {
       //system("netstat -an");
       cerr << "ERROR: tcp bind:  " << strerror(errno) << endl;
       VLOG_ERR(VLOG << "ERROR: tcp bind:  " << strerror(errno) << "  IP: "
                << toStringIP(ip_addr) << " ipPort: " << ip_port << endl);
       close(s);
       return r;
    }
    else {
       VLOG_INF(VLOG << "Successfully bound to IP: " << toStringIP(ip_addr) << " port: "
                << ip_port << endl);
    }

    nonblock(s);
    return s;
}


You will need to enable the send-to-self flag with something like this:

             // Set us up to accept local-generate packets if the kernel can support
             // it... (send-to-self)
             struct ifreq ifr;
             int fd = socket(PF_INET, SOCK_DGRAM, 0);
             if (fd < 0) {
                mudlog << "ERROR: socket: " << strerror(errno) << endl;
             }
             else {
                memset(&ifr, 0, sizeof(struct ifreq));

                // query to see if we are set up for send-to-self
                strcpy(ifr.ifr_name, dev_name);
                ifr.ifr_addr.sa_family = AF_INET;
                if (ioctl(fd, 0x89a1, &ifr) < 0) {
                   VLOG_ERR(VLOG << "ERROR: send-to-self ioctl(0x89a1): " << strerror(errno)
                            << " ifr.ifr_name -:" << ifr.ifr_name << ":-" << endl);
                   setSendToSelf(false);
                }
                else {
                   if (ifr.ifr_flags) {
                      setSendToSelf(true);
                   }
                   else {
                      // Try to make send_to_self true
                      memset(&ifr, 0, sizeof(struct ifreq));

                      strcpy(ifr.ifr_name, dev_name);
                      ifr.ifr_addr.sa_family = AF_INET;
                      ifr.ifr_flags = 1;
                      if (ioctl(fd, 0x89a0, &ifr) < 0) {
                         VLOG_ERR(VLOG << "ERROR: send-to-self ioctl(0x89a0): "
                                  << strerror(errno) << " ifr.ifr_name -:"
                                  << ifr.ifr_name << ":-" << endl);
                         setSendToSelf(false);
                      }
                      else {
                         setSendToSelf(true);
                         VLOG_ERR(VLOG << "Set send-to-self bit to true for interface: "
                                  << ifr.ifr_name << endl);
                      }
                   }//else, try to enable send-to-self
                }//else, we could read send-to-self IOCTL
                close(fd);
             }//else, could open socket


Hope that helps,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

