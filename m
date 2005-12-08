Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbVLHHVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbVLHHVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 02:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbVLHHVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 02:21:05 -0500
Received: from main.gmane.org ([80.91.229.2]:63716 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161007AbVLHHVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 02:21:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: previa.bbs@bbs.csie.ncue.edu.tw (Southern Cross)
Subject: CyberLink For Java
Date: 08 Dec 2005 07:02:38 GMT
Organization: Legend
Message-ID: <A11PFMKE$P_Previa@bbs.csie.ncue.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bbs.ncue.edu.tw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://jsourcery.com/output/sourceforge/cyberlink/1.7.0/org/cybergarage/upnp/ssdp/HTTPMUSocket.source.html
0  /**
1   *
2   *   CyberLink for Java
3   *
4   *   Copyright (C) Satoshi Konno 2002-2004
5   *
6   *   File: HTTPMU.java
7   *
8   *   Revision;
9   *
10   *  11/18/02
11   *      - first revision.
12   *  09/03/03
13   *      - Changed to open the socket using setReuseAddress().
14   *  12/10/03
15   *      - Fixed getLocalAddress() to return a valid interface address.
16   *  02/28/04
17   *      - Added getMulticastInetAddress(), getMulticastAddress().
18   *  11/19/04
19   *      - Theo Beisch <theo.beisch@gmx.de>
20   *      - Changed send() to set the TTL as 4.
21   *
22  */
23   package org.cybergarage.upnp.ssdp;
24  import java.net.*;
25
26  import java.util.*;
27
28  import org.cybergarage.http.*;
29
30  import org.cybergarage.util.*;
31
32
33  public class HTTPMUSocket {
34



35      private InetSocketAddress ssdpMultiGroup = null;
36      private MulticastSocket ssdpMultiSock = null;
37      private NetworkInterface ssdpMultiIf = null;
38
39      public HTTPMUSocket() {
40          super();
41      }
42
43      public HTTPMUSocket(String addr, int port, String bindAddr) {
44          super();
45          open(addr, port, bindAddr);
46      }
47
48      protected void finalize() {
49          close();
50      }
51
52      public String getLocalAddress() {
53          InetAddress mcastAddr = ssdpMultiGroup.getAddress();
54          Enumeration addrs = ssdpMultiIf.getInetAddresses();
55          while (addrs.hasMoreElements()) {
56              InetAddress addr = (InetAddress)addrs.nextElement();
57              if (mcastAddr instanceof Inet6Address && addr instanceof Inet6Address) return addr.getHostAddress();
58              if (mcastAddr instanceof Inet4Address && addr instanceof Inet4Address) return addr.getHostAddress();
59          }
60          return "";
61      }
62
63      public InetAddress getMulticastInetAddress() {
64          return ssdpMultiGroup.getAddress();
65      }
66
67      public String getMulticastAddress() {
68          return getMulticastInetAddress().getHostAddress();
69      }
70
71      public boolean open(String addr, int port, String bindAddr) {
72          try {
73              ssdpMultiSock = new MulticastSocket(null);
74              ssdpMultiSock.setReuseAddress(true);
75              InetSocketAddress bindSockAddr = new InetSocketAddress(port);
76              ssdpMultiSock.bind(bindSockAddr);
77              ssdpMultiGroup = new InetSocketAddress(InetAddress.getByName(addr), port);
78              ssdpMultiIf = NetworkInterface.getByInetAddress(InetAddress.getByName(bindAddr));
79              ssdpMultiSock.joinGroup(ssdpMultiGroup, ssdpMultiIf);
80          } catch  (Exception e) {
81              Debug.warning(e);
82              return false;
83          }
84          return true;
85      }
86
87      public boolean close() {
88          if (ssdpMultiSock == null) return true;
89          try {
90              ssdpMultiSock.leaveGroup(ssdpMultiGroup, ssdpMultiIf);
91              ssdpMultiSock = null;
92          } catch  (Exception e) {
93              return false;
94          }
95          return true;
96      }
97
98      public boolean send(String msg, String bindAddr, int bindPort) {
99          try {
100              MulticastSocket msock;
101              if ((bindAddr) != null && (0 < bindPort)) {
102                  msock = new MulticastSocket(null);
103                  msock.bind(new InetSocketAddress(bindAddr, bindPort));
104              } else msock = new MulticastSocket();
105              DatagramPacket dgmPacket = new DatagramPacket(msg.getBytes(), msg.length(), ssdpMultiGroup);
106              msock.setTimeToLive(4);
107              msock.send(dgmPacket);
108              msock.close();
109          } catch  (Exception e) {
110              Debug.warning(e);
111              return false;
112          }
113          return true;
114      }
115
116      public boolean send(String msg) {
117          return send(msg, null, -1);
118      }
119
120      public boolean post(HTTPRequest req, String bindAddr, int bindPort) {
121          return send(req.toString(), bindAddr, bindPort);
122      }
123
124      public boolean post(HTTPRequest req) {
125          return send(req.toString(), null, -1);
126      }
127
128      public SSDPPacket receive() {
129          byte[] ssdvRecvBuf = new byte[SSDP.RECV_MESSAGE_BUFSIZE];
130          SSDPPacket recvPacket = new SSDPPacket(ssdvRecvBuf, ssdvRecvBuf.length);
131          recvPacket.setLocalAddress(getLocalAddress());
132          try {
133              ssdpMultiSock.receive(recvPacket.getDatagramPacket());
134              recvPacket.setTimeStamp(System.currentTimeMillis());
135          } catch  (Exception e) {
136          }
137          return recvPacket;
138      }
139  }


Copyright 2005 eSystemTech Inc.

--
 [1;41m¡÷[44m¡õ[m O[1mri[30mgi[mn: [1;43m Alpha_Project£»ªüº¸µo´ú¸Õ­p¹º [47m bbs.csie.ncue.edu.tw [m
 [1;45m¡ô[42m¡ö[m Au[1mt[30mho[mr: [1;33mprevia[m ±q [1;34m218-170-136-64.dynamic.hinet.net[m µoªí

