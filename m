Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLFSmZ>; Wed, 6 Dec 2000 13:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130163AbQLFSmQ>; Wed, 6 Dec 2000 13:42:16 -0500
Received: from grace.speakeasy.org ([216.254.0.2]:8461 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S129431AbQLFSmF>; Wed, 6 Dec 2000 13:42:05 -0500
Date: Wed, 6 Dec 2000 13:12:13 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: <linux-kernel@vger.kernel.org>
cc: Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@metabyte.com>,
        <peter@cadcamlab.org>, <kai@thphy.uni-duesseldorf.de>
Subject: YMF PCI - thanks, glitches, patches (fwd)
Message-ID: <Pine.LNX.4.30.0012061254420.1411-100010@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="839566344-936960036-976062106=:825"
Content-ID: <Pine.LNX.4.30.0012051921520.1024@fonzie.nine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--839566344-936960036-976062106=:825
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.30.0012051921521.1024@fonzie.nine.com>

Hello!

The Linux-sound list appears to be dead (I don't see my message in
http://www.kernelnotes.org/lnxlists/linux-sound/), so I'm sending to the
authors and the people discussing the problem on the linux-kernel mailing
list.

An additional problem is that opl3 cannot find the device unless I load
and unload the old driver (ymf_sb). Probably the new driver should put the
OPL3 interface to the legacy mode if it cannot handle it directly.

This confirms my point that you should not disable building both drivers
as modules at this stage.

Regards,
Pavel Roskin

---------- Forwarded message ----------
Date: Tue, 5 Dec 2000 19:26:34 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: linux-sound@vger.kernel.org
Subject: YMF PCI - thanks, glitches, patches

Hello!

The native YMF PCI driver from Linux-2.4.0-test12-pre5 works on my card:

Dec  5 18:07:11 fonzie kernel: ymfpci0: YMF740C at 0xf0000000 IRQ 10
Dec  5 18:07:11 fonzie kernel: ac97_codec: AC97 Audio codec, id:
0x4144:0x5303 (Unknown)

Thanks to everybody who made it!

Now about problems. Sometimes I get such messages in the log:

Dec  5 18:08:16 fonzie kernel: ymfpci: ioctl cmd 0x5401
Dec  5 18:08:50 fonzie last message repeated 9 times

While playing some sounds I'm getting

$ play spinout.wav
sox: Unable to set audio speed to 5512 (set to 8000)
$ file spinout.wav
spinout.wav: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 8 bit,
mono 5512 Hz

This always happens for some sounds, and never happens for others. This
message doesn't appear with the old driver (ymf_sb). I'm attaching
spinout.wav.

The next problem is the configuration file, linux/drivers/sound/Config.in.
I'm sending you a patch that fixes the following problems:

1) The new driver does not depend (directly or indirectly) on the OSS
sound.o module, thus CONFIG_SOUND_YMFPCI should not depend on
CONFIG_SOUND_OSS.

2) CONFIG_SOUND_YMFPCI should depend on CONFIG_PCI. You cannot compile the
driver without PCI support.

3) Both drivers (native and legacy) should disable the other driver if
eigther of them is to be compiled into the kernel. However, it should be
possible to compile both drivers as modules. I did it so I can compare
them.

4) Don't forget about spaces in the description.

You may also want to add a dependency to CONFIG_EXPERIMENTAL for
CONFIG_SOUND_YMFPCI (not in my patch) if you feel that the driver is not
ready for everybody. Just writing (EXPERIMENTAL) doesn't disable the
question about the driver when CONFIG_EXPERIMENTAL is not set.

The patch also contains minimal descriptions for CONFIG_SOUND_YMPCI and
CONFIG_SOUND_YMFPCI. I hope somebody will add more stuff there.

By the way, I'm surprised why many drivers for PCI sound cards don't
depend on CONFIG_PCI.

Regards,
Pavel Roskin

_______________________
--- linux/Documentation/Configure.help	Tue Dec  5 10:08:10 2000
+++ linux/Documentation/Configure.help	Tue Dec  5 17:57:26 2000
@@ -14250,6 +14250,18 @@

   If unsure, say Y.

+Yamaha PCI native mode support (EXPERIMENTAL)
+CONFIG_SOUND_YMFPCI
+  This is an experimental driver that uses Yamaha PCI sound cards in
+  the native mode. You may also want to try another driver,
+  "Yamaha PCI legacy mode support" under the OSS drivers.
+
+Yamaha PCI legacy mode support
+CONFIG_SOUND_YMPCI
+  This is a driver for Yamaha PCI sound cards that turns them
+  to the Sound Blaster compatible mode. You don't need to enable
+  Sound Blaster support to use it.
+
 ACI mixer (miroPCM12/PCM20)
 CONFIG_SOUND_ACI_MIXER
   ACI (Audio Command Interface) is a protocol used to communicate with
--- linux/drivers/sound/Config.in	Tue Dec  5 10:08:13 2000
+++ linux/drivers/sound/Config.in	Tue Dec  5 17:59:30 2000
@@ -79,6 +79,9 @@
 fi

 dep_tristate '  VIA 82C686 Audio Codec' CONFIG_SOUND_VIA82CXXX $CONFIG_PCI
+if [ "$CONFIG_SOUND_YMPCI" != "y" ]; then
+  dep_tristate '  Yamaha PCI native mode support (EXPERIMENTAL)' CONFIG_SOUND_YMFPCI $CONFIG_SOUND $CONFIG_PCI
+fi

 dep_tristate '  OSS sound modules' CONFIG_SOUND_OSS $CONFIG_SOUND

@@ -142,9 +145,8 @@
    dep_tristate '    Yamaha FM synthesizer (YM3812/OPL-3) support' CONFIG_SOUND_YM3812 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA1 audio controller' CONFIG_SOUND_OPL3SA1 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA2, SA3, and SAx based PnP cards' CONFIG_SOUND_OPL3SA2 $CONFIG_SOUND_OSS
-   dep_tristate '    Yamaha PCI legacy mode support' CONFIG_SOUND_YMPCI $CONFIG_SOUND_OSS $CONFIG_PCI
-   if [ "$CONFIG_SOUND_YMPCI" = "n" ]; then
-     dep_tristate 'Yamaha PCI native mode support (EXPERIMENTAL)' CONFIG_SOUND_YMFPCI $CONFIG_SOUND_OSS
+   if [ "$CONFIG_SOUND_YMFPCI" != "y" ]; then
+     dep_tristate '    Yamaha PCI legacy mode support' CONFIG_SOUND_YMPCI $CONFIG_SOUND_OSS $CONFIG_PCI
    fi
    dep_tristate '    6850 UART support' CONFIG_SOUND_UART6850 $CONFIG_SOUND_OSS

_______________________

--839566344-936960036-976062106=:825
Content-Type: AUDIO/X-WAV; NAME="spinout.wav"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0012051921460.825@fonzie.nine.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="spinout.wav"

UklGRv4PAABXQVZFZm10IBAAAAABAAEAiBUAAIgVAAABAAgAZGF0Ya0PAACK
fot7jX6MfY97jnyJf4aBhIV+h4KKfI57kHuTe5B5knKMepB7iHiFgomGi4eA
iYGOeZJ1kXWNeJFwl3CIiI+GiHp6h4GKjIGBlmyRgZJ+k2iPeIN5hX6bgJV6
hoaBjoR+hohslHCTfJZ9mXSHcJhtioSIh3ySdJyHk3aOUZ9olHiReY1/ioaO
iYqDhJGBdoZ8hH2FjIZ/gLZPlXSFfqN0lHt7eJZqm2WKlYCbe4N2l3uUX51w
fKGdcJt/hVaWXqB1n3yGk3OmgZltjFibWo5zmG+fgJ2OgoKSeYaTd4R5i3mJ
d5B7kHuSeZJ7kn+Pe4h8hYGEhn+JfIx9j3yPe5B6j3mMeox+ioCIgoWEhIiA
iX+Lfo18jHuLfI59i36IgYeChYSChoWHgYt+jH6Jf4h+h4CEfouChYWGhoWJ
hYaCjHqEf4p+h3mEgYuBj4KGgoeIgYp/iH+DgYt8jXx8jIqGiHl9f4mBl3uI
j3uCkIaJiHZ+hHl/gH+Yg5N9h4WGh411jIN0iH6Ei4eKjIN8e457fY+AjniT
d5OPjX6HXot8fYt/jHuPe5KCkoKIf5GEdId5h3mIiIp9fbRih4V4h5iBiIZ1
epJwk3F+n3uagIF3k4CQaY+Ba6Odc5GFhVmOZpOClIOCnW+rh5h1eWeRXod9
boiljoqMgY6IiJaMb5B1d3SNWo+KioiMmoZwqnttk5CIhYJqco90eZ59jHiZ
fJKNkH2KgoCNdn2DdXiHjaZunod8gop3joCBgIV8hZZqmoqHfHaAlG6afXeI
jWK1eYhxmHaVkIRjpXt2kWV/gYuPkYGed5NynmeQkoZ1dmiAc46Vgo2gUpSo
VoaTrnKajmdyqGRlsXpSr39ujahVl6pUjpx8Zq99bGqCWbyRkp6Sp4aFfnJt
c3iBlGVJinWtaZFqi3aQf5GM0X6zi5uKfHlubWZscIaLV4qJmJd5jXKKeYmA
j6enpZ2giIFSWWlzcYaNj4BqgZaamaOak3hefH+GgZKFinBkh4iYip2Kj2Vt
gIaLlpKHg117f5uXnm5/ioCSbXSXkIxpc4WJmXl1mY2admGRiaCCaoiPh3do
kIikdl2Lj5GMZY2kkYxejI+QdVWbgaFzY6yGeICjdWqdj1SDpnJqlZeQX6OX
dnCXoWxwln59X6l3koCqbHqAh2uAqXh7pYRdl5R8g6WDboOJaYqXUJubeY+X
g3egd4eDd5Rwb55jjZSEcJ2FgKthnop3iYdup2looG5+kHiQcZR/qG6TmXSK
eZR2rFeLbX1zf3CXjoycjomUg3KLh4aEeFqSgYKHloCTe3encHazYnejbYuX
ZIyQYJ2EfZl8eZ1phJVulpZqlYdirnZ4om54omaVkGmTjWaocnegd3SmcXue
aoqYdoWSYZ9/d5l9c7NqjY9tiZVymn9mmHh1oHl6n3iDjIN8jm6sfnicdnGn
cnGddHubdYWJepN8j4Z6gqBmkZJrgZJkn5Jym4CGlHt6lGqJiXOQi1GgcoeV
f3aZaIuUc46mdp2JdJ1yfJFqeJdmh5VliphspXx1koN0l3h5qnmJoHmLlliD
gGuPhn6Zh2ybeYCkgImaaHmNbouEcqSEeZV4f6N3iphuiXlrjo9znIt8goly
oIx9jHd9i392lHGKlnN/m3iUi22QjHGTfnyOnHiGgHaXdWyUdouVdIqTgJCK
YaR3g4mEgJF/a55qnX9vm36BjIWAjXaTgHWafXSGkXl/kYeNjHaOmV2VkmiG
iXSTbpaJZYaRb4eWgJmIhn2KfJF5h5Brg5Jki5Z5hJ5ekpp1jqNlmHlvl3tq
nnpumX2Aj4p1q3KEmXKBnm2XjmGQgWGae3iYhXucin2ah3qUh2GgcIJ8c4SL
aJSSe6WJhZKJZo5/hJF4cI2GeZaLe5txfpl2gJZxiJJzhZhokopik41/lYF+
m3h2nXKFkneDkHCHjG+Yh3GWgHyZe3Opb4CYc3+ZdYSba4aMgYCPgImKf3iM
doGNioKLfIOMgo2NeG+abIaMh3yYeoWIiIaBeYyMa5WHaaKDa6Nzfp1xiIl5
lXKAlHp5oW+BoHJ9l3d7onyHl3+AkmSZbnWVh3ehaISOeImPeomUaZ58dpyI
fJ5ujoh5gJNxh4t3iINulIGCkHx+jnp+mnaQl3yKkniRfnCFfXWOgn6Vd4CN
g4yTh4qGb4KFeouEg4+EeY13jJN+iYZ+dYyFgZSEi4lwkHh+mnuAgoV+jnyL
iXmVg3KZeX6TeHyZco2LcZOKfoeCeZl5bpV6gptujJV+iZRkmYxxjnp3loBs
nnmFl26MmXGNjWqXfHmSfoWWcH+aeYGNgouLdY2Ob5WCe4t7hoZ6hpltjZN4
g5J7kYN/g3yAjnuCmHeIjW2GlnaLk3CMhn+Mi32LgHmOfnaTg3mTgIqJfoWJ
gIR7hIeLg4iKfn+ChICFhX2GiXmTiIKPhHqVd4yEdIZ/eoh9ep1+i5GCgJhy
gJV1joxohYltk497lIB9mHl8lHp/jnZ9k3SMjXWUgIKPhn2PfnySc4aVdJCH
couFdJSJe5F9gYx/gZJ5gZJyjoaBi4h8jn6Kh3yFhn+DiXSQin2TiXyLfIqF
g4SQao+BdZCIdpWGfo2HhId5g5Nxi451i5Jvj4V7kX9+kXWMhX2RhHiTgHSb
fXyRfHqYeYaNfoqKc5F+d5CDfZl4e5BykIJ5hIt3lH98lIp+m3mGjnmEi3WF
iHiNhHGSe32TdoqJfoKOdZKNfZCHgZF7d4d0gop9iIx5h4h/lYl9kYR2inuB
jXqNhn2Hf3uMhYSPg4mEeYuFf4yIf4KIe4mKe417h4mDhIaAioh/iImDh4Z+
hIeBiYN9h4KKhoSDioKBf4aGjX2FhoaHhX6FjIKGf4SEi3qEiISJf4WIh4KB
h4WDhYSCiIp9hIWJgXuMgISDgomGgoqFgYGLfoaChoGAhIeAhYuHgY2AgYqB
g4eEhICCg3+GiX+Ih4CIin2Ih3iNfn6MgX+PfoOOg4CMe4aMd4WLeYyKepN9
fI2AgIt9hIqAhIx+iYaCgYp+hox1jYF+jH98k32HioCFjHuDi36JiHqHiH6M
hYSHg4KIhH+FhIKGhYKHhYWIfoSGgoaEhoOFgIWFgoqEhoWDf4aDg4qDhIWB
hYaDhIh9iYSFg4mAh4OChIiChIx8ioOAg4OCiIKKgoiEiYKJhIR/goSBhoOH
f4uFg4mLf4d9iISAiIV8j4F+ioSAi4CGhIOAiIeDgYOJfomGgIKKfYiMgIaI
f4mCgYl7gouChYp5iIOGg4V8ioKEiIKDj4KIh4GJgoCEhXuIgoKLgIKKf4eE
g4WJgImEgI6FgIyDg4h7goV9hYmBh4R+iYSFi4SDi31+i3yIhoGHhn+FhH6L
hYSKg4OCg4SHg4aJfoWIe4yCg4WBg4aCgYuBh4l+iIt9i4N7i4N/jXyCjoGF
i3uJh36Gh36NgX6OgYWLf4GRfYaFfYiKeoeFf4x/goyChIeAh4Z/i4GAj4B/
iYGHg4WGhX+FiIKEh4GHgISGgIOJgYKHgYSGhIiEhYl+hYaAhIqBhISCg4WF
g4WFhYeFhoKJgIaFgIWFf4mEgoiHgIaHgIqCf4qDgI59h4h8hoZ8iIWAh4WB
i4aBi4KBioKAjnqFhHyHh3uNhYCOg4KLgX2MfoSJfIOJfYiIgouEgImAgoiC
g4eChIeChYaBhoWCiYGGh4SDhYKDhoOGhoKChISEhYSFgoSFg4aDhYSEhIWC
hoWCh4KDhoWBi4CEhoGDh4GFhYWFhoKGhIOJg4KChYCHg4aDhoaFg4qChIOF
hYOFhoGIh4GGhYOHhYSEhYODioODhIaBh4aDgoWEhImDg4aFhIWChYGDhYaC
iICFg4aEg4KEhoSFg4OIiISGgoaDhYCGgIKFg4WFgIaEhISFgoWFgoeChoiC
hYiDhYN/hISCh4WDiIKEh4SHiIOGhX2GhIOGhIOGhIGGgYWIg4aGgoKFg4aG
g4eDgYmAhYeBhYSDhIaAiIWCiIKCioGFh36FiH+IhH+JhYKIgoKJgYKIgYaI
foiGgoiFfoyEgoiBg4qBgomAiIZ/ioWBh4OCiIGFhn+Ihn6GhYOEhYOGg4KI
g4KHgoWFgYaDgYiFf4eDg4aEhYeBh4OBh4OAiYSBhoKChoSEhYSEhoSHg4WE
g4SEg4WDhIeDhYiDg4mChoaBhYeAiYSCiYGCiIGDh4GFhoKFiIKHhoGGhn+K
goCHgIOJf4WKgImGgoeGfoiEgYmCgIiCg4iChoeBhYWBhoWChYSChoSEh4OD
hoKGhYOGhIOFhYKGhISHg4OFg4WGhIWEgoaEhISEhISEhIWDhoKFhISDh4GH
hYKGg4KFhISEhYWFhYSGg4aEhYGFgoWEhYOFhYSEhoSDhISFg4WFgoWHgYWF
g4WFg4WEhYKGhISDhoOEh4ODhYWDiISEhoSDhoKFhIKFhYKHgoKFhIWDhIOG
goaEg4aHg4eChYSEg4WDg4WEhIWChoSDhYSEhYSChoOFh4SFh4OFg4GEhIKF
hYOHg4SFhIaGhIaFgYWEg4aEhIaFg4WDhIeEhoaEg4SEhIWEhYSBhoODh4KF
hISEhYKFhYOGhIKHhIOHgoOHgoWFgYWGg4WEgoeDgYaEg4eAhYaDhYaBhoaC
hoODhoWBh4OEhoKFhoOFhYOGhISHgoWHgoWGhISFhYWEgoaFgoWFg4WDhYSD
hYaBhYWDhIWEhoOGhIOFhIKGhoOEhIOEhYSEhYOEhIWEhIWDhYKDhYODhoOE
hoSDhoOFhoKEhoKGhYKHg4KGg4OGg4SGhISHg4WGg4OHgYaFgIaDgoaDgoiC
hoaDhYaBhIaChoSBhYSDhoSEhoOEhoOEhYSEhYOEhYOFhIOFg4SFhISFg4SE
g4SFhIWEg4SEhIWEhISDhYSEhISFhIWEhISFg4WEhISFg4SFg4WEg4SEg4WE
hYOFhIWDhYSFgoSEhISEhISFhIWFhYOFg4aEhIWEg4eDg4WEhIWEhYSEhIWF
hIOFhYOGhISEhYOGhoOFhYSFhISFgoWFhIWFg4WEhYSEhIWEhYSDhYaDhoSE
hIODhISChYOEhYKEhIOEhISDhYKFhIOGhIOGhISEgoODg4SEg4WEgoWEhIWE
hIWCg4WChISEhIWDhISDhoSEhYSDhISEhYSFhYOFhYKGhISEhIOFhIOFg4SF
goWFgoWEgoWEg4aChIaDhIWDhYSDhIWDhoODhoSEhoODh4KFhYKFhoKFhIOG
goSGg4OFg4WEg4WFhIaEg4WEhYOFg4WDhYWDhIWEhIOEhoODhoODhYKFg4WE
hIOFgoSEg4SFg4ODgoSDhoOEg4aChIWEhIOFg4SDhYKFhYOFhISEhISEg4OG
g4SFg4WDgABMSVNUGAAAAElORk9JQ1JEDAAAADE5OTYtMDMtMjAASWZhY3QE
AAAArQ8AAA==
--839566344-936960036-976062106=:825--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
