Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTKHQ2C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 11:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTKHQ2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 11:28:02 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:42369 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261807AbTKHQ1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 11:27:46 -0500
Date: Sat, 8 Nov 2003 17:27:37 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: EFAULT reading /dev/mem... - broken x86info
Message-ID: <20031108162737.GB26350@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,
  today I attempted to run 'x86info' on my system, and I was awarded by
a bit unexpected answer:

ppc:~/x# x86info -v
x86info v1.12b.  Dave Jones 2001-2003
Feedback to <davej@redhat.com>.

readEntry: Bad address
Found 1 CPUppc:~/x


After some tweaking around I found that I cannot read some pages from /dev/mem -
- I get -EFAULT on them. x86info run to the 0x86000 and 0x87000 pages, as it
scans 0x80000-0x8FFFF range for mptable.

After some thinking I believe that CONFIG_DEBUG_PAGEALLOC
is responsible for this problem. Should x86info (and other programs which
attempt to scan physical memory) cope with this inability to read /dev/mem, or
should be kernel fixed so /dev/mem really accesses physical memory and not kernel's
view of it? Or should I simple stop using CONFIG_DEBUG_PAGEALLOC?

							Thanks,
								Petr Vandrovec

P.S.: I'm surprised that we handle also incorrect 'from' in copy_to_user() without
oopses.

Test code + output on my system:

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main(void) {
	int f = open("/dev/mem", O_RDONLY);
	unsigned int offs;

	for (offs = 0; offs < 0x1000000; offs += 4096) {
		char buf[4096];
		int rd;

		lseek(f, offs, SEEK_SET);
		rd = read(f, buf, 4096);
		if (rd != 4096) {
			printf("Reading at 0x%08X (%u) gives %d/%m\n", offs, offs, rd);
		}
	}
	close(f);
	return 0;
}

/*

Reading at 0x00086000 (548864) gives -1/Bad address
Reading at 0x00087000 (552960) gives -1/Bad address
Reading at 0x0042E000 (4382720) gives -1/Bad address
Reading at 0x0042F000 (4386816) gives -1/Bad address
Reading at 0x00444000 (4472832) gives -1/Bad address
Reading at 0x00446000 (4481024) gives -1/Bad address
Reading at 0x00447000 (4485120) gives -1/Bad address
Reading at 0x00448000 (4489216) gives -1/Bad address
Reading at 0x00449000 (4493312) gives -1/Bad address
Reading at 0x00454000 (4538368) gives -1/Bad address
Reading at 0x00455000 (4542464) gives -1/Bad address
Reading at 0x00458000 (4554752) gives -1/Bad address
Reading at 0x00459000 (4558848) gives -1/Bad address
Reading at 0x0045C000 (4571136) gives -1/Bad address
Reading at 0x0045D000 (4575232) gives -1/Bad address
Reading at 0x0045E000 (4579328) gives -1/Bad address
Reading at 0x0045F000 (4583424) gives -1/Bad address
Reading at 0x00460000 (4587520) gives -1/Bad address
Reading at 0x00461000 (4591616) gives -1/Bad address
Reading at 0x00462000 (4595712) gives -1/Bad address
Reading at 0x00463000 (4599808) gives -1/Bad address
Reading at 0x00464000 (4603904) gives -1/Bad address
Reading at 0x00465000 (4608000) gives -1/Bad address
Reading at 0x00468000 (4620288) gives -1/Bad address
Reading at 0x00469000 (4624384) gives -1/Bad address
Reading at 0x0046A000 (4628480) gives -1/Bad address
Reading at 0x0046B000 (4632576) gives -1/Bad address
Reading at 0x0046C000 (4636672) gives -1/Bad address
Reading at 0x0046D000 (4640768) gives -1/Bad address
Reading at 0x00472000 (4661248) gives -1/Bad address
Reading at 0x00473000 (4665344) gives -1/Bad address
Reading at 0x00478000 (4685824) gives -1/Bad address
Reading at 0x00479000 (4689920) gives -1/Bad address
Reading at 0x004D2000 (5054464) gives -1/Bad address
Reading at 0x004D3000 (5058560) gives -1/Bad address
Reading at 0x004D6000 (5070848) gives -1/Bad address
Reading at 0x004D7000 (5074944) gives -1/Bad address
Reading at 0x004E0000 (5111808) gives -1/Bad address
Reading at 0x004E1000 (5115904) gives -1/Bad address
Reading at 0x004E6000 (5136384) gives -1/Bad address
Reading at 0x004E7000 (5140480) gives -1/Bad address
Reading at 0x00506000 (5267456) gives -1/Bad address
Reading at 0x00507000 (5271552) gives -1/Bad address
Reading at 0x0050E000 (5300224) gives -1/Bad address
Reading at 0x0050F000 (5304320) gives -1/Bad address
Reading at 0x00514000 (5324800) gives -1/Bad address
Reading at 0x00515000 (5328896) gives -1/Bad address
Reading at 0x00516000 (5332992) gives -1/Bad address
Reading at 0x00517000 (5337088) gives -1/Bad address
Reading at 0x0051C000 (5357568) gives -1/Bad address
Reading at 0x0051D000 (5361664) gives -1/Bad address
Reading at 0x00534000 (5455872) gives -1/Bad address
Reading at 0x00535000 (5459968) gives -1/Bad address
Reading at 0x00536000 (5464064) gives -1/Bad address
Reading at 0x00537000 (5468160) gives -1/Bad address
Reading at 0x0053A000 (5480448) gives -1/Bad address
Reading at 0x0053B000 (5484544) gives -1/Bad address
Reading at 0x00542000 (5513216) gives -1/Bad address
Reading at 0x00543000 (5517312) gives -1/Bad address
Reading at 0x0054A000 (5545984) gives -1/Bad address
Reading at 0x0054B000 (5550080) gives -1/Bad address
Reading at 0x00552000 (5578752) gives -1/Bad address
Reading at 0x00553000 (5582848) gives -1/Bad address
Reading at 0x00558000 (5603328) gives -1/Bad address
Reading at 0x00559000 (5607424) gives -1/Bad address
Reading at 0x00560000 (5636096) gives -1/Bad address
Reading at 0x00561000 (5640192) gives -1/Bad address
Reading at 0x00566000 (5660672) gives -1/Bad address
Reading at 0x00567000 (5664768) gives -1/Bad address
Reading at 0x00568000 (5668864) gives -1/Bad address
Reading at 0x00569000 (5672960) gives -1/Bad address
Reading at 0x0056A000 (5677056) gives -1/Bad address
Reading at 0x0056B000 (5681152) gives -1/Bad address
Reading at 0x0056C000 (5685248) gives -1/Bad address
Reading at 0x0056D000 (5689344) gives -1/Bad address
Reading at 0x0056E000 (5693440) gives -1/Bad address
Reading at 0x0056F000 (5697536) gives -1/Bad address
Reading at 0x00570000 (5701632) gives -1/Bad address
Reading at 0x00571000 (5705728) gives -1/Bad address
Reading at 0x00572000 (5709824) gives -1/Bad address
Reading at 0x00573000 (5713920) gives -1/Bad address
Reading at 0x00576000 (5726208) gives -1/Bad address
Reading at 0x00577000 (5730304) gives -1/Bad address
Reading at 0x0057B000 (5746688) gives -1/Bad address
Reading at 0x0057E000 (5758976) gives -1/Bad address
Reading at 0x0057F000 (5763072) gives -1/Bad address
Reading at 0x00586000 (5791744) gives -1/Bad address
Reading at 0x00587000 (5795840) gives -1/Bad address
Reading at 0x00588000 (5799936) gives -1/Bad address
Reading at 0x00589000 (5804032) gives -1/Bad address
Reading at 0x0059A000 (5873664) gives -1/Bad address
Reading at 0x0059B000 (5877760) gives -1/Bad address
Reading at 0x005A8000 (5931008) gives -1/Bad address
Reading at 0x005A9000 (5935104) gives -1/Bad address
Reading at 0x005AA000 (5939200) gives -1/Bad address
Reading at 0x005AB000 (5943296) gives -1/Bad address
Reading at 0x005AE000 (5955584) gives -1/Bad address
Reading at 0x005AF000 (5959680) gives -1/Bad address
Reading at 0x005B4000 (5980160) gives -1/Bad address
Reading at 0x005B5000 (5984256) gives -1/Bad address
Reading at 0x005C2000 (6037504) gives -1/Bad address
Reading at 0x005C3000 (6041600) gives -1/Bad address
Reading at 0x005C6000 (6053888) gives -1/Bad address
Reading at 0x005C7000 (6057984) gives -1/Bad address
Reading at 0x005D0000 (6094848) gives -1/Bad address
Reading at 0x005D1000 (6098944) gives -1/Bad address
Reading at 0x005D2000 (6103040) gives -1/Bad address
Reading at 0x005D3000 (6107136) gives -1/Bad address
Reading at 0x005DC000 (6144000) gives -1/Bad address
Reading at 0x005DD000 (6148096) gives -1/Bad address
Reading at 0x005E0000 (6160384) gives -1/Bad address
Reading at 0x005E1000 (6164480) gives -1/Bad address
Reading at 0x005EA000 (6201344) gives -1/Bad address
Reading at 0x005EB000 (6205440) gives -1/Bad address
Reading at 0x005EC000 (6209536) gives -1/Bad address
Reading at 0x005ED000 (6213632) gives -1/Bad address
Reading at 0x005EE000 (6217728) gives -1/Bad address
Reading at 0x005EF000 (6221824) gives -1/Bad address
Reading at 0x005FE000 (6283264) gives -1/Bad address
Reading at 0x005FF000 (6287360) gives -1/Bad address
Reading at 0x00622000 (6430720) gives -1/Bad address
Reading at 0x00634000 (6504448) gives -1/Bad address
Reading at 0x00635000 (6508544) gives -1/Bad address
Reading at 0x00637000 (6516736) gives -1/Bad address
Reading at 0x00638000 (6520832) gives -1/Bad address
Reading at 0x00658000 (6651904) gives -1/Bad address
Reading at 0x00659000 (6656000) gives -1/Bad address
Reading at 0x0065A000 (6660096) gives -1/Bad address
Reading at 0x0065B000 (6664192) gives -1/Bad address
Reading at 0x0065C000 (6668288) gives -1/Bad address
Reading at 0x0065D000 (6672384) gives -1/Bad address
Reading at 0x0065E000 (6676480) gives -1/Bad address
Reading at 0x0065F000 (6680576) gives -1/Bad address
Reading at 0x00668000 (6717440) gives -1/Bad address
Reading at 0x00669000 (6721536) gives -1/Bad address
Reading at 0x0066A000 (6725632) gives -1/Bad address
Reading at 0x0066B000 (6729728) gives -1/Bad address
Reading at 0x0069C000 (6930432) gives -1/Bad address
Reading at 0x0069D000 (6934528) gives -1/Bad address
Reading at 0x0069E000 (6938624) gives -1/Bad address
Reading at 0x0069F000 (6942720) gives -1/Bad address
Reading at 0x006AA000 (6987776) gives -1/Bad address
Reading at 0x006AB000 (6991872) gives -1/Bad address
Reading at 0x006C0000 (7077888) gives -1/Bad address
Reading at 0x006C1000 (7081984) gives -1/Bad address
Reading at 0x006C4000 (7094272) gives -1/Bad address
Reading at 0x006C5000 (7098368) gives -1/Bad address
Reading at 0x006E6000 (7233536) gives -1/Bad address
Reading at 0x006E7000 (7237632) gives -1/Bad address
Reading at 0x006F0000 (7274496) gives -1/Bad address
Reading at 0x006F1000 (7278592) gives -1/Bad address
Reading at 0x00721000 (7475200) gives -1/Bad address
Reading at 0x00759000 (7704576) gives -1/Bad address
Reading at 0x0078C000 (7913472) gives -1/Bad address
Reading at 0x0078D000 (7917568) gives -1/Bad address
Reading at 0x0078E000 (7921664) gives -1/Bad address
Reading at 0x0078F000 (7925760) gives -1/Bad address
Reading at 0x0079A000 (7970816) gives -1/Bad address
Reading at 0x0079B000 (7974912) gives -1/Bad address
Reading at 0x007AA000 (8036352) gives -1/Bad address
Reading at 0x007B2000 (8069120) gives -1/Bad address
Reading at 0x007B3000 (8073216) gives -1/Bad address
Reading at 0x007BA000 (8101888) gives -1/Bad address
Reading at 0x007BB000 (8105984) gives -1/Bad address
Reading at 0x007BC000 (8110080) gives -1/Bad address
Reading at 0x007BD000 (8114176) gives -1/Bad address
Reading at 0x007BE000 (8118272) gives -1/Bad address
Reading at 0x007C8000 (8159232) gives -1/Bad address
Reading at 0x007C9000 (8163328) gives -1/Bad address
Reading at 0x007CA000 (8167424) gives -1/Bad address
Reading at 0x007CB000 (8171520) gives -1/Bad address
Reading at 0x007EC000 (8306688) gives -1/Bad address
Reading at 0x007ED000 (8310784) gives -1/Bad address
Reading at 0x00800000 (8388608) gives -1/Bad address
Reading at 0x00801000 (8392704) gives -1/Bad address
Reading at 0x00802000 (8396800) gives -1/Bad address
Reading at 0x00803000 (8400896) gives -1/Bad address
Reading at 0x00804000 (8404992) gives -1/Bad address
Reading at 0x00805000 (8409088) gives -1/Bad address
Reading at 0x00806000 (8413184) gives -1/Bad address
Reading at 0x00807000 (8417280) gives -1/Bad address
Reading at 0x00808000 (8421376) gives -1/Bad address
Reading at 0x00809000 (8425472) gives -1/Bad address
Reading at 0x0080A000 (8429568) gives -1/Bad address
Reading at 0x0080B000 (8433664) gives -1/Bad address
Reading at 0x0080C000 (8437760) gives -1/Bad address
Reading at 0x0080D000 (8441856) gives -1/Bad address
Reading at 0x0080E000 (8445952) gives -1/Bad address
Reading at 0x0080F000 (8450048) gives -1/Bad address
Reading at 0x00810000 (8454144) gives -1/Bad address
Reading at 0x00811000 (8458240) gives -1/Bad address
Reading at 0x00812000 (8462336) gives -1/Bad address
Reading at 0x00813000 (8466432) gives -1/Bad address
Reading at 0x00814000 (8470528) gives -1/Bad address
Reading at 0x00815000 (8474624) gives -1/Bad address
Reading at 0x00816000 (8478720) gives -1/Bad address
Reading at 0x00817000 (8482816) gives -1/Bad address
Reading at 0x00818000 (8486912) gives -1/Bad address
Reading at 0x00819000 (8491008) gives -1/Bad address
Reading at 0x0081A000 (8495104) gives -1/Bad address
Reading at 0x0081B000 (8499200) gives -1/Bad address
Reading at 0x0081C000 (8503296) gives -1/Bad address
Reading at 0x0081D000 (8507392) gives -1/Bad address
Reading at 0x0081E000 (8511488) gives -1/Bad address
Reading at 0x0081F000 (8515584) gives -1/Bad address
Reading at 0x00820000 (8519680) gives -1/Bad address
Reading at 0x00821000 (8523776) gives -1/Bad address
Reading at 0x00822000 (8527872) gives -1/Bad address
Reading at 0x00823000 (8531968) gives -1/Bad address
Reading at 0x00824000 (8536064) gives -1/Bad address
Reading at 0x00825000 (8540160) gives -1/Bad address
Reading at 0x00826000 (8544256) gives -1/Bad address
Reading at 0x00827000 (8548352) gives -1/Bad address
Reading at 0x00828000 (8552448) gives -1/Bad address
Reading at 0x00829000 (8556544) gives -1/Bad address
Reading at 0x0082A000 (8560640) gives -1/Bad address
Reading at 0x0082B000 (8564736) gives -1/Bad address
Reading at 0x0082C000 (8568832) gives -1/Bad address
Reading at 0x0082D000 (8572928) gives -1/Bad address
Reading at 0x0082E000 (8577024) gives -1/Bad address
Reading at 0x0082F000 (8581120) gives -1/Bad address
Reading at 0x00830000 (8585216) gives -1/Bad address
Reading at 0x00831000 (8589312) gives -1/Bad address
Reading at 0x00832000 (8593408) gives -1/Bad address
Reading at 0x00833000 (8597504) gives -1/Bad address
Reading at 0x00834000 (8601600) gives -1/Bad address
Reading at 0x00835000 (8605696) gives -1/Bad address
Reading at 0x00836000 (8609792) gives -1/Bad address
Reading at 0x00837000 (8613888) gives -1/Bad address
Reading at 0x00838000 (8617984) gives -1/Bad address
Reading at 0x00839000 (8622080) gives -1/Bad address
Reading at 0x0083A000 (8626176) gives -1/Bad address
Reading at 0x0083B000 (8630272) gives -1/Bad address
Reading at 0x0083C000 (8634368) gives -1/Bad address
Reading at 0x0083D000 (8638464) gives -1/Bad address
Reading at 0x0083E000 (8642560) gives -1/Bad address
Reading at 0x0083F000 (8646656) gives -1/Bad address
Reading at 0x00840000 (8650752) gives -1/Bad address
Reading at 0x00841000 (8654848) gives -1/Bad address
Reading at 0x00842000 (8658944) gives -1/Bad address
Reading at 0x00843000 (8663040) gives -1/Bad address
Reading at 0x00844000 (8667136) gives -1/Bad address
Reading at 0x00845000 (8671232) gives -1/Bad address
Reading at 0x00846000 (8675328) gives -1/Bad address
Reading at 0x00847000 (8679424) gives -1/Bad address
Reading at 0x00870000 (8847360) gives -1/Bad address
Reading at 0x00871000 (8851456) gives -1/Bad address
Reading at 0x00872000 (8855552) gives -1/Bad address
Reading at 0x00873000 (8859648) gives -1/Bad address
Reading at 0x00874000 (8863744) gives -1/Bad address
Reading at 0x00875000 (8867840) gives -1/Bad address
Reading at 0x00876000 (8871936) gives -1/Bad address
Reading at 0x00877000 (8876032) gives -1/Bad address
Reading at 0x00878000 (8880128) gives -1/Bad address
Reading at 0x00879000 (8884224) gives -1/Bad address
Reading at 0x0087A000 (8888320) gives -1/Bad address
Reading at 0x0087B000 (8892416) gives -1/Bad address
Reading at 0x0087C000 (8896512) gives -1/Bad address
Reading at 0x0087D000 (8900608) gives -1/Bad address
Reading at 0x0087E000 (8904704) gives -1/Bad address
Reading at 0x0087F000 (8908800) gives -1/Bad address
Reading at 0x00888000 (8945664) gives -1/Bad address
Reading at 0x00889000 (8949760) gives -1/Bad address
Reading at 0x0088A000 (8953856) gives -1/Bad address
Reading at 0x0088B000 (8957952) gives -1/Bad address
Reading at 0x0088C000 (8962048) gives -1/Bad address
Reading at 0x0088D000 (8966144) gives -1/Bad address
Reading at 0x0088E000 (8970240) gives -1/Bad address
Reading at 0x0088F000 (8974336) gives -1/Bad address
Reading at 0x00890000 (8978432) gives -1/Bad address
Reading at 0x00891000 (8982528) gives -1/Bad address
Reading at 0x00892000 (8986624) gives -1/Bad address
Reading at 0x00893000 (8990720) gives -1/Bad address
Reading at 0x00894000 (8994816) gives -1/Bad address
Reading at 0x00895000 (8998912) gives -1/Bad address
Reading at 0x00896000 (9003008) gives -1/Bad address
Reading at 0x00897000 (9007104) gives -1/Bad address
Reading at 0x00898000 (9011200) gives -1/Bad address
Reading at 0x00899000 (9015296) gives -1/Bad address
Reading at 0x0089A000 (9019392) gives -1/Bad address
Reading at 0x0089B000 (9023488) gives -1/Bad address
Reading at 0x0089C000 (9027584) gives -1/Bad address
Reading at 0x0089D000 (9031680) gives -1/Bad address
Reading at 0x0089E000 (9035776) gives -1/Bad address
Reading at 0x0089F000 (9039872) gives -1/Bad address
Reading at 0x008B0000 (9109504) gives -1/Bad address
Reading at 0x008C0000 (9175040) gives -1/Bad address
Reading at 0x008C1000 (9179136) gives -1/Bad address
Reading at 0x008C2000 (9183232) gives -1/Bad address
Reading at 0x008C3000 (9187328) gives -1/Bad address
Reading at 0x008C4000 (9191424) gives -1/Bad address
Reading at 0x008C5000 (9195520) gives -1/Bad address
Reading at 0x008C6000 (9199616) gives -1/Bad address
Reading at 0x008C7000 (9203712) gives -1/Bad address
Reading at 0x008C8000 (9207808) gives -1/Bad address
Reading at 0x008C9000 (9211904) gives -1/Bad address
Reading at 0x008CA000 (9216000) gives -1/Bad address
Reading at 0x008CB000 (9220096) gives -1/Bad address
Reading at 0x008CC000 (9224192) gives -1/Bad address
Reading at 0x008CD000 (9228288) gives -1/Bad address
Reading at 0x008CE000 (9232384) gives -1/Bad address
Reading at 0x008CF000 (9236480) gives -1/Bad address
Reading at 0x008E0000 (9306112) gives -1/Bad address
Reading at 0x008E1000 (9310208) gives -1/Bad address
Reading at 0x008E2000 (9314304) gives -1/Bad address
Reading at 0x008E3000 (9318400) gives -1/Bad address
Reading at 0x008E4000 (9322496) gives -1/Bad address
Reading at 0x008E5000 (9326592) gives -1/Bad address
Reading at 0x008E6000 (9330688) gives -1/Bad address
Reading at 0x008E7000 (9334784) gives -1/Bad address
Reading at 0x008E8000 (9338880) gives -1/Bad address
Reading at 0x008E9000 (9342976) gives -1/Bad address
Reading at 0x008EA000 (9347072) gives -1/Bad address
Reading at 0x008EB000 (9351168) gives -1/Bad address
Reading at 0x008EC000 (9355264) gives -1/Bad address
Reading at 0x008ED000 (9359360) gives -1/Bad address
Reading at 0x008EE000 (9363456) gives -1/Bad address
Reading at 0x008EF000 (9367552) gives -1/Bad address
Reading at 0x00900000 (9437184) gives -1/Bad address
Reading at 0x00901000 (9441280) gives -1/Bad address
Reading at 0x00902000 (9445376) gives -1/Bad address
Reading at 0x00903000 (9449472) gives -1/Bad address
Reading at 0x00904000 (9453568) gives -1/Bad address
Reading at 0x00905000 (9457664) gives -1/Bad address
Reading at 0x00906000 (9461760) gives -1/Bad address
Reading at 0x00907000 (9465856) gives -1/Bad address
Reading at 0x00908000 (9469952) gives -1/Bad address
Reading at 0x00909000 (9474048) gives -1/Bad address
Reading at 0x0090A000 (9478144) gives -1/Bad address
Reading at 0x0090B000 (9482240) gives -1/Bad address
Reading at 0x0090C000 (9486336) gives -1/Bad address
Reading at 0x0090D000 (9490432) gives -1/Bad address
Reading at 0x0090E000 (9494528) gives -1/Bad address
Reading at 0x0090F000 (9498624) gives -1/Bad address
Reading at 0x00910000 (9502720) gives -1/Bad address
Reading at 0x00911000 (9506816) gives -1/Bad address
Reading at 0x00912000 (9510912) gives -1/Bad address
Reading at 0x00913000 (9515008) gives -1/Bad address
Reading at 0x00914000 (9519104) gives -1/Bad address
Reading at 0x00915000 (9523200) gives -1/Bad address
Reading at 0x00916000 (9527296) gives -1/Bad address
Reading at 0x00917000 (9531392) gives -1/Bad address
Reading at 0x00918000 (9535488) gives -1/Bad address
Reading at 0x00919000 (9539584) gives -1/Bad address
Reading at 0x0091A000 (9543680) gives -1/Bad address
Reading at 0x0091B000 (9547776) gives -1/Bad address
Reading at 0x0091C000 (9551872) gives -1/Bad address
Reading at 0x0091D000 (9555968) gives -1/Bad address
Reading at 0x0091E000 (9560064) gives -1/Bad address
Reading at 0x0091F000 (9564160) gives -1/Bad address
Reading at 0x00920000 (9568256) gives -1/Bad address
Reading at 0x00921000 (9572352) gives -1/Bad address
Reading at 0x00922000 (9576448) gives -1/Bad address
Reading at 0x00923000 (9580544) gives -1/Bad address
Reading at 0x00924000 (9584640) gives -1/Bad address
Reading at 0x00925000 (9588736) gives -1/Bad address
Reading at 0x00926000 (9592832) gives -1/Bad address
Reading at 0x00927000 (9596928) gives -1/Bad address
Reading at 0x00928000 (9601024) gives -1/Bad address
Reading at 0x00929000 (9605120) gives -1/Bad address
Reading at 0x0092E000 (9625600) gives -1/Bad address
Reading at 0x0092F000 (9629696) gives -1/Bad address
Reading at 0x00940000 (9699328) gives -1/Bad address
Reading at 0x00941000 (9703424) gives -1/Bad address
Reading at 0x00942000 (9707520) gives -1/Bad address
Reading at 0x00943000 (9711616) gives -1/Bad address
Reading at 0x00944000 (9715712) gives -1/Bad address
Reading at 0x00945000 (9719808) gives -1/Bad address
Reading at 0x00946000 (9723904) gives -1/Bad address
Reading at 0x00947000 (9728000) gives -1/Bad address
Reading at 0x00950000 (9764864) gives -1/Bad address
Reading at 0x00951000 (9768960) gives -1/Bad address
Reading at 0x00952000 (9773056) gives -1/Bad address
Reading at 0x00953000 (9777152) gives -1/Bad address
Reading at 0x00954000 (9781248) gives -1/Bad address
Reading at 0x00955000 (9785344) gives -1/Bad address
Reading at 0x00956000 (9789440) gives -1/Bad address
Reading at 0x00957000 (9793536) gives -1/Bad address
Reading at 0x00958000 (9797632) gives -1/Bad address
Reading at 0x00959000 (9801728) gives -1/Bad address
Reading at 0x0095A000 (9805824) gives -1/Bad address
Reading at 0x0095B000 (9809920) gives -1/Bad address
Reading at 0x0095C000 (9814016) gives -1/Bad address
Reading at 0x0095D000 (9818112) gives -1/Bad address
Reading at 0x0095E000 (9822208) gives -1/Bad address
Reading at 0x0095F000 (9826304) gives -1/Bad address
Reading at 0x00970000 (9895936) gives -1/Bad address
Reading at 0x00971000 (9900032) gives -1/Bad address
Reading at 0x00972000 (9904128) gives -1/Bad address
Reading at 0x00973000 (9908224) gives -1/Bad address
Reading at 0x00974000 (9912320) gives -1/Bad address
Reading at 0x00975000 (9916416) gives -1/Bad address
Reading at 0x00976000 (9920512) gives -1/Bad address
Reading at 0x00977000 (9924608) gives -1/Bad address
Reading at 0x00978000 (9928704) gives -1/Bad address
Reading at 0x00979000 (9932800) gives -1/Bad address
Reading at 0x0097A000 (9936896) gives -1/Bad address
Reading at 0x0097B000 (9940992) gives -1/Bad address
Reading at 0x0097C000 (9945088) gives -1/Bad address
Reading at 0x0097D000 (9949184) gives -1/Bad address
Reading at 0x0097E000 (9953280) gives -1/Bad address
Reading at 0x0097F000 (9957376) gives -1/Bad address
Reading at 0x00988000 (9994240) gives -1/Bad address
Reading at 0x00989000 (9998336) gives -1/Bad address
Reading at 0x0098A000 (10002432) gives -1/Bad address
Reading at 0x0098B000 (10006528) gives -1/Bad address
Reading at 0x00990000 (10027008) gives -1/Bad address
Reading at 0x00991000 (10031104) gives -1/Bad address
Reading at 0x00992000 (10035200) gives -1/Bad address
Reading at 0x00993000 (10039296) gives -1/Bad address
Reading at 0x00994000 (10043392) gives -1/Bad address
Reading at 0x00995000 (10047488) gives -1/Bad address
Reading at 0x00996000 (10051584) gives -1/Bad address
Reading at 0x00997000 (10055680) gives -1/Bad address
Reading at 0x00998000 (10059776) gives -1/Bad address
Reading at 0x00999000 (10063872) gives -1/Bad address
Reading at 0x0099A000 (10067968) gives -1/Bad address
Reading at 0x0099B000 (10072064) gives -1/Bad address
Reading at 0x0099C000 (10076160) gives -1/Bad address
Reading at 0x0099D000 (10080256) gives -1/Bad address
Reading at 0x0099E000 (10084352) gives -1/Bad address
Reading at 0x0099F000 (10088448) gives -1/Bad address
Reading at 0x009B3000 (10170368) gives -1/Bad address
Reading at 0x009C3000 (10235904) gives -1/Bad address
Reading at 0x009F4000 (10436608) gives -1/Bad address
Reading at 0x009F5000 (10440704) gives -1/Bad address
Reading at 0x009FC000 (10469376) gives -1/Bad address
Reading at 0x009FD000 (10473472) gives -1/Bad address
Reading at 0x00A26000 (10641408) gives -1/Bad address
Reading at 0x00A44000 (10764288) gives -1/Bad address
Reading at 0x00A45000 (10768384) gives -1/Bad address
Reading at 0x00A46000 (10772480) gives -1/Bad address
Reading at 0x00A47000 (10776576) gives -1/Bad address
Reading at 0x00A78000 (10977280) gives -1/Bad address
Reading at 0x00A79000 (10981376) gives -1/Bad address
Reading at 0x00A7A000 (10985472) gives -1/Bad address
Reading at 0x00A7B000 (10989568) gives -1/Bad address
Reading at 0x00A95000 (11096064) gives -1/Bad address
Reading at 0x00A9C000 (11124736) gives -1/Bad address
Reading at 0x00A9D000 (11128832) gives -1/Bad address
Reading at 0x00A9E000 (11132928) gives -1/Bad address
Reading at 0x00A9F000 (11137024) gives -1/Bad address
Reading at 0x00AA0000 (11141120) gives -1/Bad address
Reading at 0x00AAD000 (11194368) gives -1/Bad address
Reading at 0x00AAF000 (11202560) gives -1/Bad address
Reading at 0x00AB5000 (11227136) gives -1/Bad address
Reading at 0x00ACC000 (11321344) gives -1/Bad address
Reading at 0x00ACD000 (11325440) gives -1/Bad address
Reading at 0x00ACE000 (11329536) gives -1/Bad address
Reading at 0x00ACF000 (11333632) gives -1/Bad address
Reading at 0x00AD0000 (11337728) gives -1/Bad address
Reading at 0x00AD1000 (11341824) gives -1/Bad address
Reading at 0x00AD2000 (11345920) gives -1/Bad address
Reading at 0x00AD3000 (11350016) gives -1/Bad address
Reading at 0x00AF0000 (11468800) gives -1/Bad address
Reading at 0x00AF1000 (11472896) gives -1/Bad address
Reading at 0x00AF2000 (11476992) gives -1/Bad address
Reading at 0x00AF3000 (11481088) gives -1/Bad address
Reading at 0x00B12000 (11608064) gives -1/Bad address
Reading at 0x00B9C000 (12173312) gives -1/Bad address
Reading at 0x00B9D000 (12177408) gives -1/Bad address
Reading at 0x00B9E000 (12181504) gives -1/Bad address
Reading at 0x00B9F000 (12185600) gives -1/Bad address
Reading at 0x00BC4000 (12337152) gives -1/Bad address
Reading at 0x00BC5000 (12341248) gives -1/Bad address
Reading at 0x00BC6000 (12345344) gives -1/Bad address
Reading at 0x00BC7000 (12349440) gives -1/Bad address
Reading at 0x00C22000 (12722176) gives -1/Bad address
Reading at 0x00C23000 (12726272) gives -1/Bad address
Reading at 0x00CB2000 (13312000) gives -1/Bad address
Reading at 0x00CB4000 (13320192) gives -1/Bad address
Reading at 0x00CB5000 (13324288) gives -1/Bad address
Reading at 0x00CB6000 (13328384) gives -1/Bad address
Reading at 0x00CB7000 (13332480) gives -1/Bad address
Reading at 0x00CBC000 (13352960) gives -1/Bad address
Reading at 0x00CBD000 (13357056) gives -1/Bad address
Reading at 0x00CBE000 (13361152) gives -1/Bad address
Reading at 0x00CBF000 (13365248) gives -1/Bad address
Reading at 0x00CC4000 (13385728) gives -1/Bad address
Reading at 0x00CC5000 (13389824) gives -1/Bad address
Reading at 0x00CC6000 (13393920) gives -1/Bad address
Reading at 0x00CC7000 (13398016) gives -1/Bad address
Reading at 0x00CF3000 (13578240) gives -1/Bad address
Reading at 0x00CF8000 (13598720) gives -1/Bad address
Reading at 0x00CF9000 (13602816) gives -1/Bad address
Reading at 0x00CFA000 (13606912) gives -1/Bad address
Reading at 0x00CFB000 (13611008) gives -1/Bad address
Reading at 0x00D04000 (13647872) gives -1/Bad address
Reading at 0x00D05000 (13651968) gives -1/Bad address
Reading at 0x00D06000 (13656064) gives -1/Bad address
Reading at 0x00D07000 (13660160) gives -1/Bad address
Reading at 0x00D13000 (13709312) gives -1/Bad address
Reading at 0x00D33000 (13840384) gives -1/Bad address
Reading at 0x00DB0000 (14352384) gives -1/Bad address
Reading at 0x00DB1000 (14356480) gives -1/Bad address
Reading at 0x00DB2000 (14360576) gives -1/Bad address
Reading at 0x00DB3000 (14364672) gives -1/Bad address
Reading at 0x00E30000 (14876672) gives -1/Bad address
Reading at 0x00E31000 (14880768) gives -1/Bad address
Reading at 0x00E32000 (14884864) gives -1/Bad address
Reading at 0x00E33000 (14888960) gives -1/Bad address
Reading at 0x00E44000 (14958592) gives -1/Bad address
Reading at 0x00E45000 (14962688) gives -1/Bad address
Reading at 0x00E4C000 (14991360) gives -1/Bad address
Reading at 0x00E58000 (15040512) gives -1/Bad address
Reading at 0x00E64000 (15089664) gives -1/Bad address
Reading at 0x00E65000 (15093760) gives -1/Bad address
Reading at 0x00E88000 (15237120) gives -1/Bad address
Reading at 0x00E89000 (15241216) gives -1/Bad address
Reading at 0x00E8A000 (15245312) gives -1/Bad address
Reading at 0x00E8B000 (15249408) gives -1/Bad address
Reading at 0x00EC8000 (15499264) gives -1/Bad address
Reading at 0x00EC9000 (15503360) gives -1/Bad address
Reading at 0x00EE4000 (15613952) gives -1/Bad address
Reading at 0x00EE5000 (15618048) gives -1/Bad address
Reading at 0x00F10000 (15794176) gives -1/Bad address
Reading at 0x00F11000 (15798272) gives -1/Bad address
Reading at 0x00F12000 (15802368) gives -1/Bad address
Reading at 0x00F13000 (15806464) gives -1/Bad address
Reading at 0x00F44000 (16007168) gives -1/Bad address
Reading at 0x00F45000 (16011264) gives -1/Bad address
Reading at 0x00F4C000 (16039936) gives -1/Bad address
Reading at 0x00F4D000 (16044032) gives -1/Bad address
Reading at 0x00F70000 (16187392) gives -1/Bad address
Reading at 0x00F71000 (16191488) gives -1/Bad address
Reading at 0x00F72000 (16195584) gives -1/Bad address
Reading at 0x00F73000 (16199680) gives -1/Bad address
Reading at 0x00FB6000 (16474112) gives -1/Bad address
Reading at 0x00FDE000 (16637952) gives -1/Bad address
Reading at 0x00FDF000 (16642048) gives -1/Bad address
Reading at 0x00FE8000 (16678912) gives -1/Bad address
Reading at 0x00FE9000 (16683008) gives -1/Bad address
Reading at 0x00FF5000 (16732160) gives -1/Bad address

*/
