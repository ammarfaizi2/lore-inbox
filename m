Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291888AbSBHWZS>; Fri, 8 Feb 2002 17:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291887AbSBHWZJ>; Fri, 8 Feb 2002 17:25:09 -0500
Received: from smtp01.web.de ([194.45.170.210]:61191 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S291884AbSBHWYz>;
	Fri, 8 Feb 2002 17:24:55 -0500
Message-ID: <3C645047.C2C248B8@web.de>
Date: Fri, 08 Feb 2002 23:25:11 +0100
From: Olaf Zaplinski <olaf.zaplinski@web.de>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: iptables: why different behaviour with two kernel versions?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

my self made firewall at $HOME (iptables based) works fine, but the
accounting data it reports every day is not as expected.

The accounting rules are:

$IPTAB -N all-in
$IPTAB -N all-out
$IPTAB -N all-io
$IPTAB -A all-in
$IPTAB -A all-out
$IPTAB -A all-io
$IPTAB -A INPUT   -i $FW_DEV_EXT -j all-in
$IPTAB -A INPUT   -i $FW_DEV_EXT -j all-io
$IPTAB -A FORWARD                -j all-io
$IPTAB -A OUTPUT  -o $FW_DEV_EXT -j all-out
$IPTAB -A OUTPUT  -o $FW_DEV_EXT -j all-io

($FW_DEV_EXT = ppp0, ADSL)

I re-set the accounting log:

wally:~ # > /var/log/accounting
wally:~ # acct show
all-in            0.00 KBytes
all-io            0.00 KBytes
all-out           0.00 KBytes

and downloaded a file of exactly 1 MB. Then:

wally:~ # acct flush
wally:~ # acct show
all-in            0.06 KBytes
all-io         1447.77 KBytes
all-out           0.04 KBytes

(could be that client B generated some traffic also, I work at client A)
Shouldn't be all-io the summary of all-in and all-io? So I checked:

wally:~ # iptables -Z INPUT
wally:~ # iptables -Z FORWARD

... downloaded 1 MB again and ...

wally:~ # iptables -nvL INPUT
Chain INPUT (policy DROP 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source              
destination         
    0     0 all-in     all  --  ppp0   *       0.0.0.0/0           
0.0.0.0/0          
    0     0 all-io     all  --  ppp0   *       0.0.0.0/0           
0.0.0.0/0          
    0     0 ACCEPT     all  --  lo     *       0.0.0.0/0           
0.0.0.0/0          
   71  5100 ACCEPT     all  --  eth0   *       192.168.42.0/24     
192.168.42.0/24    
    0     0 log-in     all  --  ppp0   *       0.0.0.0/0           
0.0.0.0/0          state INVALID 
    0     0 log-in     all  --  ppp0   *       127.0.0.0/8         
0.0.0.0/0          
    0     0 log-in     all  --  ppp0   *       10.0.0.0/8          
0.0.0.0/0          
    0     0 log-in     all  --  ppp0   *       172.16.0.0/12       
0.0.0.0/0          
    0     0 log-in     all  --  ppp0   *       192.168.0.0/16      
0.0.0.0/0          
    0     0 ACCEPT     icmp --  ppp0   *       0.0.0.0/0           
0.0.0.0/0          icmp type 8 limit: avg 2/sec burst 2 
    0     0 LOG        icmp --  ppp0   *       0.0.0.0/0           
0.0.0.0/0          icmp type 8 limit: avg 1/sec burst 2 LOG flags 0 level 4
prefix 
`iptab-limit ' 
    0     0 DROP       icmp --  ppp0   *       0.0.0.0/0           
0.0.0.0/0          icmp type 8 
    0     0 ACCEPT     all  --  eth0   *       192.168.42.0/24     
0.0.0.0/0          state NEW,RELATED,ESTABLISHED 
    0     0 ACCEPT     udp  --  ppp0   *       0.0.0.0/0           
0.0.0.0/0          udp dpts:6970:7170 
    0     0 REJECT     tcp  --  ppp0   *       0.0.0.0/0           
62.109.72.140      tcp dpt:113 reject-with tcp-reset 
    0     0 ACCEPT     all  --  ppp0   *       0.0.0.0/0           
62.109.72.140      state RELATED,ESTABLISHED 
    0     0 log-in     all  --  ppp0   *       0.0.0.0/0           
0.0.0.0/0          state INVALID,NEW 
    0     0 log-in     all  --  *      *       0.0.0.0/0           
0.0.0.0/0          

Yup, there are many bytes missing here. And yes, this rules are probably not
perfect. ;-) But in FORWARD it's okay:

wally:~ # iptables -nvL FORWARD
Chain FORWARD (policy DROP 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source              
destination         
 1220 1088K all-io     all  --  *      *       0.0.0.0/0           
0.0.0.0/0          
   51  2448 TCPMSS     tcp  --  *      *       0.0.0.0/0           
0.0.0.0/0          tcp flags:0x06/0x02 TCPMSS clamp to PMTU 
    0     0 log-fwd    all  --  *      ppp0    192.168.42.0/24     
207.46.209.203     
    0     0 log-fwd    all  --  *      ppp0    207.46.209.203      
0.0.0.0/0          
    0     0 log-fwd    all  --  *      *       0.0.0.0/0           
127.0.0.0/8        
    0     0 log-fwd    all  --  *      *       0.0.0.0/0           
10.0.0.0/8         
    0     0 log-fwd    all  --  *      *       0.0.0.0/0           
172.16.0.0/12      
  775 1065K ACCEPT     all  --  *      *       0.0.0.0/0           
192.168.42.0/24    
    0     0 log-fwd    all  --  *      *       0.0.0.0/0           
192.168.0.0/16     
  445 22977 ACCEPT     all  --  *      ppp0    192.168.42.0/24    
!192.168.42.0/24    state NEW,RELATED,ESTABLISHED 
    0     0 ACCEPT     all  --  *      eth0   !192.168.42.0/24     
192.168.42.0/24    state RELATED,ESTABLISHED 
    0     0 log-fwd    all  --  *      *       0.0.0.0/0           
0.0.0.0/0          

So I built the 2.4.13 kernel to test that and got dozens of rejects in the
logs, e.g. UDP connects to the DNS forwarders... so I could not test the
accounting stuff. I switched back to 2.4.17 and everything was fine again.

So what's wrong with iptables-1.2.4 userland tools and 2.4.[13|17]? Why is
iptables-rules@2.4.13 not the same as iptables-rules@2.4.17?

Olaf
