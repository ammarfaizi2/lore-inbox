Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270703AbTHOSeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270700AbTHOSeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:34:03 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:48657 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S270750AbTHOSby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:31:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: "John Newbie" <john_r_newbie@hotmail.com>,
       vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: ide drives performance issues, maybe related with buffer cache.
Date: Fri, 15 Aug 2003 21:31:45 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <Law14-F28uv4hh6nB2J0002797a@hotmail.com>
In-Reply-To: <Law14-F28uv4hh6nB2J0002797a@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308152131.46070.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 August 2003 18:39, John Newbie wrote:
> >How do you copy files? cp? dd? Midnight Commander? ;)

Use dd if you want to eliminate 'small buffer' problem.
With dd you can control buffer size with bs=NNN.
I found that mc is rather suboptimal...

OTOH kernel have to take care of that...
Hmm let me test it on my 2.4.21 box:

hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=14593/255/63, UDMA(66)
hdc: 87930864 sectors (45021 MB) w/2048KiB Cache, CHS=87233/16/63, UDMA(33)

# hdparm /dev/hda;hdparm /dev/hdc
/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  0 (off)
 geometry     = 14593/255/63, sectors = 234441648, start = 0

/dev/hdc:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 5473/255/63, sectors = 87930864, start = 0

# hdparm -Tt /dev/hda
/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.88 seconds =145.45 MB/sec
 Timing buffered disk reads:  64 MB in  2.33 seconds =27.47 MB/sec

# hdparm -Tt /dev/hdc
/dev/hdc:
 Timing buffer-cache reads:   128 MB in  0.92 seconds =139.13 MB/sec
 Timing buffered disk reads:  64 MB in  2.91 seconds =21.99 MB/sec

Copying ~600M iso from hdc to hda, Midnight Commander:

# nmeter t4 b
21:17:41.0126 bio    0    0
21:17:42.0125 bio    0    0
21:17:43.0125 bio    0    0
21:17:44.0124 bio  32k    0
21:17:45.0124 bio 7.8M 204k
21:17:46.0127 bio 9.5M    0
21:17:47.0122 bio  12M    0
21:17:48.0122 bio  12M    0
21:17:49.0121 bio 7.0M    0
21:17:50.0121 bio 7.5M 216k
21:17:51.0120 bio  15M 4096
21:17:52.0120 bio  13M  13M
21:17:53.0119 bio  10M  15M
21:17:54.0118 bio 9.5M  16M
21:17:55.0118 bio 9.7M  15M
21:17:56.0118 bio 9.5M 7.1M
21:17:57.0116 bio 9.5M    0
21:17:58.0117 bio  12M  10M
21:17:59.0115 bio 9.8M  15M
21:18:00.0179 bio  12M  13M
21:18:01.0114 bio 5.1M  18M
21:18:02.0114 bio  10M 148k
21:18:03.0113 bio  10M  72k
21:18:04.0118 bio  14M 9.9M
21:18:05.0112 bio  11M  16M
21:18:06.0112 bio 8.3M  17M
21:18:07.0111 bio 5.1M  12M
21:18:08.0112 bio  14M    0
21:18:09.0110 bio  11M 9.9M
21:18:10.0111 bio  11M  13M
21:18:11.0109 bio 9.5M  17M
21:18:12.0108 bio 6.6M  16M
21:18:13.0110 bio 8.2M    0
21:18:14.0107 bio  10M    0
21:18:15.0107 bio 9.3M 9.9M
21:18:16.0108 bio 3.2M  22M
21:18:17.0105 bio  12M 736k
21:18:18.0106 bio  13M    0
21:18:19.0104 bio  10M  17M
21:18:20.0100 bio 8.6M  26M
21:18:21.4004 bio 8.7M 4096
21:18:22.0104 bio 6.1M 212k
21:18:23.0098 bio 8.8M    0
21:18:24.0198 bio  13M  13M
21:18:25.0201 bio 9.0M  20M
21:18:26.0097 bio  13M  13M
21:18:27.0196 bio  15M  16M
21:18:28.0195 bio 7.0M  12M
21:18:29.0195 bio  16M 640k
21:18:30.0200 bio  16M  11M
21:18:31.0094 bio  15M  16M
21:18:32.0193 bio 8.3M  20M
21:18:33.0192 bio 4.5M  14M
21:18:34.0192 bio  17M    0
21:18:35.0191 bio  13M  14M
21:18:36.0191 bio  10M  17M
21:18:37.0190 bio 5.6M  14M
21:18:38.0190 bio  10M 236k
21:18:39.0189 bio 3.0M    0
21:18:40.0190 bio 3.6M    0
21:18:41.0188 bio 3.3M    0
21:18:42.0188 bio 3.7M  19M
21:18:43.0187 bio 3.5M  12M
21:18:44.0186 bio 3.0M    0
21:18:45.0186 bio 3.0M    0
21:18:46.0186 bio  10M 1.8M
21:18:47.0185 bio  15M 9.9M
21:18:48.0184 bio  11M  17M
21:18:49.0184 bio 3.7M  16M
21:18:50.0183 bio  13M 400k
21:18:51.0183 bio  13M  10M
21:18:52.0182 bio 6.9M  19M
21:18:53.0181 bio 180k 8.2M
21:18:54.0181 bio 4096 236k
21:18:55.0180 bio    0    0
21:18:56.0179 bio    0    0
21:18:57.0179 bio    0    0
21:18:58.0179 bio    0    0

Ok, now with dd bs=50M:

# nmeter t4 b
21:21:26.0096 bio    0    0
21:21:27.0200 bio    0    0
21:21:28.0095 bio 1.7M    0
21:21:29.0195 bio 8.6M    0
21:21:30.0194 bio 9.0M    0
21:21:31.0194 bio  14M 352k
21:21:32.0276 bio  11M    0
21:21:33.0093 bio 4.7M 4096
21:21:34.0204 bio 2.5M 760k
21:21:35.0091 bio 9.7M    0
21:21:36.0191 bio  16M 248k
21:21:37.0190 bio  15M 1.8M
21:21:38.0198 bio 5.7M 7.1M
21:21:39.0189 bio 5.3M  20M
21:21:40.0233 bio  10M  14M
21:21:41.0094 bio  10M  10M
21:21:42.0243 bio  10M  16k
21:21:43.0091 bio  11M  20k
21:21:44.0222 bio 2.2M  12M
21:21:45.0090 bio 7.3M  18M
21:21:46.0205 bio  12M  16M
21:21:47.0088 bio  10M 5.7M
21:21:48.0188 bio  11M  28k
21:21:49.0187 bio 9.2M 1.4M
21:21:50.0191 bio 2.3M  18M
21:21:51.0186 bio  11M  15M
21:21:52.0187 bio  11M  14M
21:21:53.0185 bio  12M 2.0M
21:21:54.0196 bio  12M  48k
21:21:55.0184 bio 385k  18M
21:21:56.0185 bio  12M  16M
21:21:57.0183 bio  10M  15M
21:21:58.0184 bio  11M 420k
21:21:59.0182 bio  10M    0
21:22:00.0222 bio 5.0M 1.3M
21:22:01.0081 bio 136k  22M
21:22:02.0181 bio 2.2M  17M
21:22:03.0180 bio  10M 316k
21:22:04.0181 bio  11M 4096
21:22:05.0179 bio  12M    0
21:22:06.0179 bio  12M 8.8M
21:22:07.0178 bio 1.7M  12M
21:22:08.0177 bio    0  25M
21:22:09.0176 bio 5.2M 8.2M
21:22:10.0176 bio  10M    0
21:22:11.0176 bio 9.1M    0
21:22:12.0176 bio  10M 108k
21:22:13.0174 bio 9.2M 4.0M
21:22:14.0193 bio 6.2M 4.2M
21:22:15.0175 bio 8.7M  20M
21:22:16.0174 bio  13M  16M
21:22:17.0172 bio  16M  10M
21:22:18.0183 bio  11M 108k
21:22:19.0171 bio    0  24M
21:22:20.0175 bio 128k  17M
21:22:21.0170 bio  16M    0
21:22:22.0170 bio  17M    0
21:22:23.0170 bio  16M 7.0M
21:22:24.0168 bio 100k  25M
21:22:25.0168 bio  24k  24M
21:22:26.0175 bio  32k  10M
21:22:27.0167 bio  12M  12k
21:22:28.0257 bio  16M  10M
21:22:29.0066 bio  14M  14M
21:22:30.0165 bio 5.5M  19M
21:22:31.0164 bio 296k 364k
21:22:32.0164 bio  14M    0
21:22:33.0163 bio 2.6M    0
21:22:34.0163 bio 3.2M    0
21:22:35.0163 bio 4.3M    0
21:22:36.0163 bio 3.3M 172k
21:22:37.0164 bio 3.5M    0
21:22:38.0164 bio 3.2M 4096
21:22:39.0160 bio 2.8M    0
21:22:40.0160 bio 8.8M    0
21:22:41.0159 bio 3.6M 208k
21:22:42.0159 bio 7.6M  22M
21:22:43.0158 bio  15M  14M
21:22:44.0167 bio  13M  11M
21:22:45.0157 bio  13M 180k
21:22:46.0158 bio  21k  13M
21:22:47.0156 bio 5.1M  18M
21:22:48.0156 bio 7.5M  20M
21:22:49.0155 bio 100k  11M
21:22:50.0154 bio    0    0
21:22:51.0154 bio 4096 204k
21:22:52.0153 bio    0    0
21:22:53.0153 bio    0    0
21:22:54.0152 bio  16k    0
21:22:55.0152 bio    0    0
21:22:56.0151 bio  32k 116k

Hmm... lets try dd if=/dev/hdc of=dummy.iso count=12 bs=50M
in order to rule out 'source file is fragmented' theory...

# nmeter t4 b
21:24:45.0090 bio    0    0
21:24:46.0198 bio    0    0
21:24:47.0193 bio    0    0
21:24:48.0193 bio    0 244k
21:24:49.0195 bio    0    0
21:24:50.0192 bio    0    0
21:24:51.0191 bio 9.6M    0
21:24:52.0191 bio  21M    0
21:24:53.4651 bio  18M 884k
21:24:54.0486 bio 6.6M 520k
21:24:55.0185 bio  22M    0
21:24:56.0211 bio  20M    0
21:24:57.0091 bio  10k  18M
21:24:58.0183 bio  10M  14M
21:24:59.0183 bio  11M  11M
21:25:00.0182 bio  11M 7.9M
21:25:01.0182 bio  16M 0.9M
21:25:02.0190 bio  16k  14M
21:25:03.0181 bio 9.1M  16M
21:25:04.0181 bio 5.5M  22M
21:25:05.2880 bio  22M 292k
21:25:06.0223 bio  13M    0
21:25:07.0084 bio 1024  20M
21:25:08.0189 bio 3.5M  13M
21:25:09.0182 bio  21M    0
21:25:10.0182 bio  23M 4.2M
21:25:11.0198 bio 1.5M  15M
21:25:12.0180 bio 2.7M  20M
21:25:13.0180 bio  10M  11M
21:25:14.0212 bio  11M  12M
21:25:15.0083 bio  14M 6.0M
21:25:16.0204 bio  10M 6.6M
21:25:17.0080 bio 5.7M  18M
21:25:18.0173 bio  11M 9.9M
21:25:19.0172 bio 4.1M  17M
21:25:20.0172 bio  21M 336k
21:25:21.0204 bio 7.1M 5.9M
21:25:22.0077 bio    0  27M
21:25:23.0255 bio  11M  13M
21:25:24.0072 bio  16M 3.8M
21:25:25.0169 bio  21M 220k
21:25:26.0187 bio 642k  16M
21:25:27.0168 bio  10M  15M
21:25:28.0168 bio  11M  11M
21:25:29.0168 bio  11M 7.6M
21:25:30.0184 bio  16M 252k
21:25:31.0167 bio 2.6M  20M
21:25:32.0167 bio  11M  11M
21:25:33.0165 bio  10M  13M
21:25:34.0168 bio  17M 4.1M
21:25:35.0164 bio 7.6M 7.7M
21:25:36.0265 bio    0  24M
21:25:37.0163 bio  13M    0
21:25:38.0163 bio  22M 116k
21:25:39.0162 bio  14M  10M
21:25:40.0162 bio 4096  25M
21:25:41.0161 bio 1024  26M
21:25:42.0161 bio  14M 6.4M
21:25:43.0160 bio  20M  52k
21:25:44.0177 bio  15M    0
21:25:45.0160 bio 1024  26M
21:25:46.0158 bio 113k 7.1M
21:25:47.0158 bio 4096 236k
21:25:48.0158 bio    0    0
21:25:49.0159 bio 180k    0
21:25:50.0157 bio    0    0
21:25:51.0156 bio    0    0
21:25:52.0156 bio    0  68k
21:25:53.0155 bio 236k    0
21:25:54.0154 bio  68k    0

What can I say? You're rught, it's bursty and not quite
up to max speed...
-- 
vda
